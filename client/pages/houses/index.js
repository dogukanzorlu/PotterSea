window.addEventListener("DOMContentLoaded", (event) => {
  var scene = document.querySelector("a-scene");
  console.log("scene", scene);

  if (scene?.hasLoaded) {
    run();
  } else {
    scene.addEventListener("loaded", run);
  }

  const placeholders = [
    {
      position: "-1.99 1.6 1.5",
      scale: "0.7 0.7 0.7",
      biggerScale: "0.8 0.8 0.8",
      rotation: "0 90 0",
    },

    {
      position: "-1.99 1.6 -4",
      scale: "0.7 0.7 0.7",
      biggerScale: "0.8 0.8 0.8",
      rotation: "0 90 0",
    },
    {
      position: "-1.99 1.6 -9.5",
      scale: "0.7 0.7 0.7",
      biggerScale: "0.8 0.8 0.8",
      rotation: "0 90 0",
    },

    {
      position: "0 2.5 -14.49",
      scale: "3 3 3",
      biggerScale: "3.2 3.2 3.2",
      rotation: "0 0 0",
    },
    {
      position: "-5 2.5 -14.49",
      scale: "3 3 3",
      biggerScale: "3.2 3.2 3.2",
      rotation: "0 0 0",
    },
  ];

  function run() {
    console.log("HOUSE", window.location.href);
    let url = window.location.href;

    let house =
      url.indexOf("house=") > -1
        ? url.substring(url.indexOf("house=") + 6)
        : "gryffindor";

    fetch("http://172.17.0.1:4000/api/tokens")
      .then((res) => res.json())
      .then((json) => {
        console.log("data", json.data);
        let data = json.data.filter((d) =>
          d.meta_data[0].house.startsWith(house)
        );
        for (let i = 0; i < Math.min(placeholders.length, data.length); i++) {
          let image = data[i];
          console.log("Image", image);
          let placeholder = placeholders[i];
          let imageEl = createImage(image, placeholder);
          if (placeholder.rotation.indexOf("90") > -1) {
            scene.appendChild(createInfo(image, placeholder));
          } else {
            scene.appendChild(createInfoLeft(image, placeholder));
            scene.appendChild(createInfoRight(image, placeholder));
          }
          scene.appendChild(imageEl);
        }
      });
  }
});

function createImage(image, placeholder) {
  let imageEl = document.createElement("a-image");
  imageEl.setAttribute("src", `http://172.17.0.1:8080/ipfs/${image.ipfs_hash}`);
  imageEl.setAttribute("position", placeholder.position);
  imageEl.setAttribute("scale", placeholder.scale);
  imageEl.setAttribute("originalScale", placeholder.scale);
  imageEl.setAttribute("biggerScale", placeholder.biggerScale);
  imageEl.setAttribute("rotation", placeholder.rotation);
  imageEl.setAttribute("class", "raycastable");
  // imageEl.addEventListener("mouseenter", function (e) {
  //   e.target.setAttribute("scale", e.target.getAttribute("biggerScale"));
  // });
  // imageEl.addEventListener("mouseleave", function (e) {
  //   e.target.setAttribute("scale", e.target.getAttribute("originalScale"));
  // });
  return imageEl;
}

function createInfo(image, placeholder) {
  let leftEl = document.createElement("a-entity");
  let labels =
    "Name:\nSpecies:\nGender:\nHouse:\nBirth:\nAncestry:\nEye Color:\nHair Color:\nWand:\nPatronus:\nAlive:\nPrice:\nAcccount:\nTx:";
  leftEl.setAttribute("position", "0.075 -0.02 0.0");
  leftEl.setAttribute(
    "text",
    `
  value: ${labels}; 
  color: #fff; 
  width: 1; 
  align: left; 
  font: https://raw.githubusercontent.com/etiennepinchon/aframe-fonts/master/fonts/cabin/Cabin-Medium.json;
  shader: msdf`
  );

  let rightEl = document.createElement("a-entity");
  let v = image.meta_data[0];
  let values = `${v.name || "-"}\n${v.species.c() || "-"}\n${
    v.gender.c() || "-"
  }\n${v.house || "-"}\n${v.yearOfBirth}
  ${v.ancestry.c() || "-"}\n${v.eyeColour.c() || "-"}\n${
    v.hairColour.c() || "-"
  }\n${v.wand?.core.c() || "-"}\n${v.patronus.c()}
  ${v.alive ? "Yes" : "No"}\n${image.price || "-"}\n${
    image.user || "-"
  }\n${image.tx.substring(0, 10)}`;
  rightEl.setAttribute("position", "-0.075 -0.02 0.0");
  rightEl.setAttribute(
    "text",
    `
  value: ${values}; 
  color: #fff; 
  width: 1; 
  align: right; 
  font: https://raw.githubusercontent.com/etiennepinchon/aframe-fonts/master/fonts/cabin/Cabin-Medium.json;
  shader: msdf`
  );

  let containerEl = document.createElement("a-entity");
  let pos = placeholder.position.split(" ");
  containerEl.setAttribute(
    "position",
    `${pos[0]} ${pos[1] - 0.1} ${pos[2] - 0.9}`
  );
  containerEl.setAttribute("rotation", placeholder.rotation);
  containerEl.setAttribute("material", "color: #222");
  containerEl.setAttribute(
    "geometry",
    "primitive: plane; width: 1; height: 0.9"
  );
  containerEl.appendChild(leftEl);
  containerEl.appendChild(rightEl);
  return containerEl;
}

function createInfoLeft(image, placeholder) {
  let leftEl = document.createElement("a-entity");
  let labels =
    "Name:\nSpecies:\nGender:\nHouse:\nBirth:\nAncestry:\nEye Color:";
  leftEl.setAttribute("position", "0.075 -0.02 0.0");
  leftEl.setAttribute(
    "text",
    `
  value: ${labels}; 
  color: #fff; 
  width: 1; 
  align: left; 
  font: https://raw.githubusercontent.com/etiennepinchon/aframe-fonts/master/fonts/cabin/Cabin-Medium.json;
  shader: msdf`
  );

  let rightEl = document.createElement("a-entity");
  let v = image.meta_data[0];
  let values = `${v.name || "-"}\n${v.species.c() || "-"}\n${
    v.gender.c() || "-"
  }\n${v.house || "-"}\n${v.yearOfBirth}
  ${v.ancestry || "-"}\n${v.eyeColour || "-"}`;
  rightEl.setAttribute("position", "-0.075 -0.02 0.0");
  rightEl.setAttribute(
    "text",
    `
  value: ${values}; 
  color: #fff; 
  width: 1; 
  align: right; 
  font: https://raw.githubusercontent.com/etiennepinchon/aframe-fonts/master/fonts/cabin/Cabin-Medium.json;
  shader: msdf`
  );

  let containerEl = document.createElement("a-entity");
  let pos = placeholder.position.split(" ");
  containerEl.setAttribute(
    "position",
    `${pos[0] - 0.5} ${pos[1] - 2} ${pos[2]}`
  );

  //  "0 2.5 -14.49"
  // "-0.5 0.5 -14.49"
  containerEl.setAttribute("rotation", placeholder.rotation);
  containerEl.setAttribute("material", "color: #222");
  containerEl.setAttribute(
    "geometry",
    "primitive: plane; width: 1; height: 0.5"
  );
  containerEl.appendChild(leftEl);
  containerEl.appendChild(rightEl);
  return containerEl;
}

function createInfoRight(image, placeholder) {
  let leftEl = document.createElement("a-entity");
  let labels = "Hair Color:\nWand:\nPatronus:\nAlive:\nPrice:\nAcccount:\nTx:";
  leftEl.setAttribute("position", "0.075 -0.02 0.0");
  leftEl.setAttribute(
    "text",
    `
  value: ${labels}; 
  color: #fff; 
  width: 1; 
  align: left; 
  font: https://raw.githubusercontent.com/etiennepinchon/aframe-fonts/master/fonts/cabin/Cabin-Medium.json;
  shader: msdf`
  );

  let rightEl = document.createElement("a-entity");
  let v = image.meta_data[0];
  let values = `${v.hairColour.c() || "-"}\n${
    v.wand?.core.c() || "-"
  }\n${v.patronus.c()}
  ${v.alive ? "Yes" : "No"}\n${image.price || "-"}\n${
    image.user || "-"
  }\n${image.tx.substring(0, 10)}`;
  rightEl.setAttribute("position", "-0.075 -0.02 0.0");
  rightEl.setAttribute(
    "text",
    `
  value: ${values}; 
  color: #fff; 
  width: 1; 
  align: right; 
  font: https://raw.githubusercontent.com/etiennepinchon/aframe-fonts/master/fonts/cabin/Cabin-Medium.json;
  shader: msdf`
  );

  let containerEl = document.createElement("a-entity");
  let pos = placeholder.position.split(" ");
  containerEl.setAttribute(
    "position",
    `${parseInt(pos[0]) + 0.5} ${pos[1] - 2} ${pos[2]}`
  );

  //  "0 2.5 -14.49"
  // "-0.5 0.5 -14.49"
  containerEl.setAttribute("rotation", placeholder.rotation);
  containerEl.setAttribute("material", "color: #222");
  containerEl.setAttribute(
    "geometry",
    "primitive: plane; width: 1; height: 0.5"
  );
  containerEl.appendChild(leftEl);
  containerEl.appendChild(rightEl);
  return containerEl;
}

Object.defineProperty(String.prototype, "c", {
  value: function () {
    return this.charAt(0).toUpperCase() + this.slice(1);
  },
  enumerable: false,
});
