<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# protect photo — agent index

Disables **right-click + obscures the image source** to deter image copying (client-side). Depends on core
`image`, `jquery_ui`. Version **8.x-2.6**. Core `^8.9||^9||^10||^11`.

**CAVEAT — NOT real protection:** the image is still fully downloaded by the browser (retrievable via cache/
network tab/disabling JS/screenshot/curl). **Don't rely on it for images that must stay private** — use
server-side private-file access, watermarking, or protected derivatives. Hurts usability/accessibility. No
real access-control role.
