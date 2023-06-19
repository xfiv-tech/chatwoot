require 'aws-sdk-s3'

class Api::V1::Accounts::WhatsappBusinessController < Api::V1::Accounts::BaseController
  def index
    @whatsapp_channels = whatsapp_channels
                         .map { |channel| channel.slice(:id, :phone_number, :provider, :account_id, :created_at, :updated_at) }
    render json: @whatsapp_channels
  end

  def show
    render json: whatsapp_channel.profile_details
  end

  def update_business_profile
    response = whatsapp_channel.update_profile(profile_params)
    if response.success?
      render json: whatsapp_channel.business_profile, status: :ok
    else
      render json: response.parsed_response.slice('errors'), status: response.code
    end
  rescue HTTParty::Error => e
    render json: { errors: e.message }, status: :bad_request
  end

  def update_profile_about
    response = whatsapp_channel.update_about(params[:about])

    if response.success?
      render json: { about: whatsapp_channel.profile_about }, status: :ok
    else
      render json: response.parsed_response.slice('errors'), status: response.code
    end
  rescue HTTParty::Error => e
    render json: { errors: e.message }, status: :bad_request
  end

  def update_profile_photo
    response = whatsapp_channel.update_photo(params[:photo])
    if response.success?
      render json: { profile_photo_link: whatsapp_channel.profile_photo_link }, status: :ok
    else
      render json: response.parsed_response.slice('errors'), status: response.code
    end
  rescue HTTParty::Error => e
    render json: { errors: e.message }, status: :bad_request
  end

  def sync_templates
    whatsapp_channel.sync_templates
    render json: whatsapp_channel.message_templates
  end

  def create_template
    response = whatsapp_channel.create_template(template_params)
    if response.success?
      render json: response.parsed_response, status: :ok
    else
      render json: { errors: response.parsed_response['meta']['developer_message'] }, status: response.code
    end
  rescue HTTParty::Error => e
    render json: { errors: e.message }, status: :bad_request
  end

  def delete_template
    response = whatsapp_channel.delete_template(params[:template_name])
    if response.success?
      render json: { message: response.parsed_response['meta']['developer_message'] }, status: :ok
    else
      render json: { errors: response.parsed_response['meta']['developer_message'] }, status: response.code
    end
  rescue HTTParty::Error => e
    render json: { errors: e.message }, status: :bad_request
  end

  def s3_upload
    s3_direct_post = upload_to_s3(params[:file].content_type)

    response = HTTParty.post(s3_direct_post.url, body: s3_direct_post.fields.merge(file: params[:file]))
    if response.success?
      render json: { url: response.parsed_response.dig('PostResponse', 'Location') }
    else
      render json: { errors: response.parsed_response }, status: response.code
    end
  rescue HTTParty::Error => e
    render json: { errors: e.message }, status: :bad_request
  rescue StandardError => e
    render json: { errors: e.message }
  end

  private

  def whatsapp_channel
    @whatsapp_channel ||= whatsapp_channels.find(params[:id])
  end

  def whatsapp_channels
    @whatsapp_channels ||= Current.account.whatsapp_channels
  end

  def profile_params
    params.permit(:address, :description, :email, :vertical, websites: [])
  end

  def template_params
    params.require(:template).permit!
  end

  def upload_to_s3(content_type)
    bucket_name = ENV.fetch('S3_PUBLIC_BUCKET_NAME', '')

    s3_client = Aws::S3::Client.new(
      access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID', ''),
      secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY', ''),
      region: ENV.fetch('AWS_REGION', '')
    )

    Aws::S3::Bucket.new(bucket_name, client: s3_client).presigned_post(
      key: "#{bucket_name}/#{SecureRandom.hex}",
      success_action_status: '201',
      content_type: content_type
    )
  end
end
