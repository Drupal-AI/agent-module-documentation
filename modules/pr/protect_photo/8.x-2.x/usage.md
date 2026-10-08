<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
protect photo tries to prevent image theft by preventing right-click and obscuring the image source in the console log.

---

protect photo attempts to deter casual image copying — disabling right-click (context menu) on images
and obscuring the image source in the browser console/inspector. It depends on core Image and jQuery UI, in
the Field package.

**Important caveat — this is a client-side deterrent, NOT real protection.** Disabling right-click and
hiding the source URL only stops the most casual copying; the image is still fully downloaded by the browser
to be displayed, so anyone can retrieve it via the browser cache, network tab, disabling JavaScript,
screenshotting, or `curl`-ing the URL. **Do not rely on it to protect images that must genuinely stay
private** — for that, restrict the file's access at the server (private file system with access checks),
watermark, or serve lower-resolution/protected derivatives. It also degrades usability/accessibility
(right-click has legitimate uses). Treat it as a light deterrent only. It has no real access-control role.
Enable it where a mild "please don't copy" signal is wanted.

---

- Disable right-click on images.
- Obscure the image source.
- Deter casual image copying.
- Depend on core Image and jQuery UI.
- KNOW it is not real protection.
- Understand the image is still downloaded.
- Not rely on it for private images.
- Use server-side access for real protection.
- Consider watermarking/protected derivatives.
- Be aware it hurts usability/accessibility.
- Treat it as a light deterrent only.
- Have no real access-control role.
- Restrict private images at the server instead.
- Enable as a mild signal.
- Deter right-click.
- Hide the source URL.
- Understand the bypasses.
- Not protect sensitive images with it.
- Use private files for real protection.
- Enable the deterrent.
