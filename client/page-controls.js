/* global AFRAME, THREE */
AFRAME.registerComponent("page-controls", {
  init: function () {
    var el = this.el;

    this.velocity = new THREE.Vector3();
    this.acceleration = new THREE.Vector3();
    this.friction = 2.0;
    this.turnPage = this.turnPage.bind(this);
    document.addEventListener("click", this.turnPage);
  },

  turnPage: function (e) {
    if (!e.target.id) return;
    console.log(e.target.id);
    window.location.href = `./pages/houses/index.html?house=${e.target.id}`;
  },
});
