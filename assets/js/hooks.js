import flatpickr from "flatpickr";
let Hooks = {};

Hooks.InfiniteScroll = {
  mounted() {
    console.log("Footer added to DOM!", this.el);
    this.observer = new IntersectionObserver((entries) => {
      const entry = entries[0];
      if (entry.isIntersecting) {
        console.log("Footer is visible!");
        this.pushEvent("load-more");
      }
    });

    this.observer.observe(this.el);
  },
  updated() {
    const pageNumber = this.el.dataset.pageNumber;
    console.log("updated", pageNumber);
  },
  destroyed() {
    this.observer.disconnect();
  },
};

Hooks.DatePicker = {
  mounted() {
    console.log(`DatePicker mounted:`, this.el);
    flatpickr(this.el, {
      enableTime: false,
      dateFormat: "d F, Y",
      onChange: this.handleDatePicked.bind(this),
    });
  },
  updated() {},
  handleDatePicked(selectedDates, dateStr, instance) {
    // send the dateStr to the LiveView
    console.log(`${selectedDates}, ${dateStr}`, instance);
    this.pushEvent("date_changed", { date: dateStr });
  },
};

export default Hooks;
