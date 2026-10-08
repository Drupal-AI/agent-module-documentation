<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTML5 Package (h5p_package) — agent index

**Upload and view interactive H5P (HTML5) content packages** (a fork of the h5p module). Depends on core `field`,
`file`. Provides permissions. Version **3.1.0-beta2**. Core `^11`.

Media/content — **H5P packages bundle JS/CSS/HTML that execute in the browser**, so uploading one is uploading
**active code** (XSS risk from a malicious package). Restrict the H5P upload/create permission to **trusted
authors**; source libraries/content from trusted origins; treat authoring as privileged (like raw HTML/JS).
