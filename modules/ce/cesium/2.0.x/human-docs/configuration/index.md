# Configuration

Cesium has a small settings form for the library, and the real work — turning a
Geofield into a 3D globe — happens on a content type's display.

## Global settings form

1. Log in as an administrator.
2. Go to **Configuration → Web services → Cesium settings**
   (`/admin/config/services/cesium`).

The form has two settings:

- **Cesium library variant** — choose **Production (minified)** for better
  performance on live sites, or **Development (unminified)** when you need to
  debug the CesiumJS code.
- **Cesium Ion Access Token** — enter the access token from your
  [Cesium Ion](https://cesium.com/ion/) account. This removes the watermark
  warning and unlocks Cesium's default global imagery and terrain datasets. It's
  optional, but the globe looks unfinished without it. Treat the token as a
  credential — if you'd rather not store it in exported configuration, manage it as
  a secret and set it per environment.

## Render a Geofield as a 3D globe

1. Add a **Geofield** to a content type (for example, Article).
2. Go to that content type's **Manage display**
   (**Structure → Content types → *(your type)* → Manage display**).
3. Set the Geofield's format to **Cesium Globe**.
4. Click the **cog icon** next to the formatter to set the **zoom altitude** — the
   camera height in meters the 3D viewer uses when it flies to the point.

## Enter spatial data and view it

When creating content, enter spatial data into the Geofield — for example
`POINT (lon lat)`. On display, the field renders as an interactive 3D Cesium globe
that automatically flies the camera to the specified location and altitude. The
formatter accepts multiple Geofield input formats, including WKT and raw
latitude/longitude pairs.
