# Ratio Crop — agent index

Adds one configurable core **Image effect**, `image_crop_ratio` ("Ratio crop"), that crops an
image to a fixed `W:H` aspect ratio using a 9-point anchor. No routes, no permissions, no
settings form, no Drush — all state lives inside an **image style** config entity
(`image.style.<name>`). Depends only on core `image`.

- **Add / configure the effect on an image style, its config keys and the GD operation it uses** →
  [plugins/image-effect.md](plugins/image-effect.md)

Key fact: an image style effect entry looks like
`{ id: image_crop_ratio, data: { aspect_ratio: "16:9", anchor: "center-center" } }`.
`aspect_ratio` must match `^[0-9]+:[0-9]+$`; `anchor` is one of
`left-top center-top right-top left-center center-center right-center left-bottom center-bottom right-bottom`.
