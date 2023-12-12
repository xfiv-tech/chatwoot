<template>
  <div class="billing-container">
    <div class="billing-title">
      <p>Billing</p>
    </div>
    <!-- caja -->
    <div class="history">
      <div class="history_container">
        <div class="order_history">
          <div class="order_history_title">
            <p class="title">Order History</p>
            <p>Manage Billing information and view receips</p>
          </div>
          <div class="order_history_table">
            <div class="order_history_table_head">
              <p>Date</p>
              <p>Type</p>
              <p>Receipt</p>
            </div>
            <div>
              <div v-for="(sub, i) in mock"> 
                <div class="order_history_table_body">
                  <p>{{ sub.date }}</p>
                  <p>{{ sub.type }}</p>
                  <div class="btn_download">
                    <p>Download</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="user_plan">
          <div class="user_plan_box">
            <p>Your Plan</p>
            <p class="title">Pro Annual</p>
            <p>Renews on Nov. 2022</p>
            <div class="btn_sub">
              <p>Cancel subscription</p>
            </div>
          </div>
        </div>
      </div>
      <div class="">
        <div>
          <p>Payment methods</p>
          <p>Manage Billing information and view receipts</p>
        </div>
        <div>
          card info
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  mixins: [
  ],
  data() {
    return {
      mock: [
        {
          date: 'Oct. 21, 2021',
          type: 'Pro Annual'
        },
        {
          date: 'Aug. 21, 2021',
          type: 'Pro Portfolio'
        },
        {
          date: 'July. 21, 2021',
          type: 'Sponsored Post'
        },
        {
          date: 'Jun. 21, 2021',
          type: 'Sponsored Post'
        },
      ]
    };
  },
  computed: {
  },
  watch: {
  },
  mounted() {
  },
  methods: {
  },
};
</script>
<style lang="scss">
  .billing-container {
    margin: 5rem;
  }
  .billing-title {
    color: #4aaad6;
    font-weight: bold;
    p {font-size: 3rem;}
    margin-bottom: 2rem;
  }
  .history {
    width: 100%;
    height: auto;
    &_container {
      width: inherit;
      height: auto;
      display: flex;
    }
    .order_history {
      width: 80%;
      &_title {
        color: #131313;
        font-size: 1.5rem;
        margin-bottom: 2rem;
        p {
          margin-bottom: 1rem;
        }
      }
      &_table {
        width: 90%;
        &_head {
          display: grid;
          grid-template-columns: repeat(3, 1fr);
          grid-column-gap: 0px;
          grid-row-gap: 0px;
          margin-bottom: 1rem;
          padding: 0 1rem;
          font-weight: bold;
          color: #a4a4a4;
        }
        &_body {
          font-weight: 600;
          width: 100%;
          height: auto;
          margin: 1rem 0;
          padding: .8rem 1rem;
          display: grid;
          border: .5px solid #5b5b5b;
          border-radius: 10px;
          background-color: #FFFFFF;
          grid-template-columns: repeat(3, 1fr);
          align-items: center;
          grid-column-gap: 0px;
          grid-row-gap: 0px;
          .btn_download {
            font-size: 1.5rem;
            color: #3EC1FF;
            border: 1px solid #3EC1FF;
            border-radius: 5px;
            text-align: center;
            max-width: 12rem;
            font-weight: 600;
            p {
              padding: 5px;
            }
          }
        }
      }
    }
    .user_plan {
      width: 20%;
      &_box {
        background-color: #4aaad6;
        padding: 2.5rem;
        border-radius: 20px;
        color: #FFFFFF;
        font-size: 1.5rem;
        p {
          margin-bottom: 1rem;
        }
        .btn_sub {
          width: 100%;
          height: auto;
          border: 1px solid #FFFFFF;
          border-radius: 5px;
          font-weight: 600;
          p {
            padding: 1rem;
            font-size: 1.7rem;
            margin: 0;
            text-align: center;
          }
        }
      }
    }
  }

  .title {
    font-size: 1.4rem;
    // font-weight: bold;
  }
</style>
