<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTML5 Package lets you upload and view interactive HTML5 (H5P) packages.

---

HTML5 Package (h5p_package) **lets you upload and view interactive H5P content** — H5P (HTML5 Package) is a
format for interactive content (quizzes, presentations, interactive video) rendered in the browser. This module
(a fork of the h5p module) provides the field/upload and viewer. It depends on core Field and File, and provides
its own permissions.

Use it to author/embed H5P interactive content. It is a media/content feature with an important security property:
**H5P packages bundle JavaScript, CSS and HTML that execute in the visitor's browser**, so uploading an H5P
package is effectively uploading **active client-side code** — a malicious or compromised package could run
arbitrary JS (XSS) in the context of anyone viewing it. Therefore **restrict the H5P upload/create permission to
trusted authors only**, obtain H5P libraries/content from trusted sources, and treat H5P authoring as a
privileged capability (comparable to allowing raw HTML/JS). It has no broader access-control role. Configure the
H5P permissions and libraries.

---

- Upload and view H5P content.
- Render interactive HTML5 (quizzes/video).
- Provide the H5P field + viewer.
- Depend on core Field + File.
- Provide its own permissions.
- Fork the h5p module.
- BUNDLE JS/CSS/HTML that executes in the browser (active code).
- RISK arbitrary JS (XSS) from a malicious/compromised package.
- Restrict the H5P upload/create permission to trusted authors.
- Obtain H5P libraries/content from trusted sources.
- Treat H5P authoring as privileged (like raw HTML/JS).
- Configure the H5P permissions and libraries.
- Handle H5P content.
- Upload H5P.
- Configure the permissions.
- View H5P.
- Handle the packages.
- Render interactives.
- Restrict authoring.
- Provide H5P support.
