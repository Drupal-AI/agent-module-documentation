<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Kraken.io is an Image Optimize (`imageapi_optimize`) processor that sends derivative images to the Kraken.io web service for compression, including lossy mode and WebP output.

---

Image Optimize lets a site build pipelines of processors that run over derivative images. Most processors shell out to a local binary such as `jpegoptim` or `pngquant`; this one offloads to a paid web service instead, which is the right trade when you want aggressive, format-aware compression (and WebP) without installing and maintaining binaries on every environment. Install it with Composer (which pulls the `kraken-io/kraken-php` client automatically), then add a **Kraken.io** processor to a pipeline at `/admin/config/media/imageapi-optimize-pipelines` and enter your account **API key** and **API secret**, plus the **lossy** and **WebP** toggles. Point an image style — or the sitewide default — at that pipeline under `/admin/config/media/image-styles`, and every derivative it generates is uploaded to Kraken.io, optimized, downloaded, and written back in place. Each optimized derivative is therefore a synchronous round trip to a third party, so first-render latency of new derivatives depends on Kraken.io, and the **Status report** shows a per-account line with the plan name and remaining quota (warning under 5%). An optional **success logging** checkbox records each optimization to the `imageapi_optimize` log channel; errors are always logged there.

---

- Optimize derivative images through Kraken.io.
- Offload image compression to a web service.
- Produce WebP derivatives from a pipeline.
- Use lossy compression for smaller files.
- Choose lossless compression when needed.
- Add a Kraken processor to an Image Optimize pipeline.
- Avoid installing local optimization binaries per environment.
- Compress images aggressively and format-aware.
- Configure the processor per pipeline.
- Apply a pipeline to a single image style.
- Apply a pipeline as the sitewide image default.
- Monitor Kraken.io plan and remaining quota on the status report.
- Get warned when account quota drops below 5%.
- Enable success logging to the watchdog for debugging.
- Route Kraken traffic through a configured HTTPS proxy.
- Weigh a paid service against local binaries.
- Combine with responsive image styles.
- Convert JPEG/PNG derivatives to WebP for delivery.
- Share one Kraken.io account across multiple pipelines.
- Restrict Image Optimize administration to trusted roles.
