# protect photo — manual setup guide

**protect photo** (`protect_photo`) is a light client‑side deterrent against casual
image copying. It disables the right‑click context menu on images and obscures the
image source in the browser console and inspector by drawing the image onto an HTML5
canvas rather than exposing a plain `<img>` source. It is applied per image field
through a display formatter called **Protect photo Viewer**.

**Please read this before relying on it.** protect photo is a *deterrent, not real
protection.* To display an image, the browser must download it — so anyone can still
retrieve it from the browser cache, the network tab, by disabling JavaScript, by taking
a screenshot, or by fetching the URL directly with a tool like `curl`. It also degrades
usability and accessibility, since right‑click has legitimate uses. Treat it as a mild
"please don't copy" signal only.

If you need images to genuinely stay private, do not use this module for that. Instead,
restrict the file at the server (a private file system with access checks), apply
watermarks, or serve lower‑resolution or otherwise protected derivatives. protect photo
has no real access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page** for this module. You turn the deterrent on per
image field, from that field's display settings — described in "How to use it" below.

## How to use it

1. Go to the **Manage display** page of any bundle that has an image field — for
   example **Structure → Content types → Basic page → Manage display**
   (`admin/structure/types/manage/page/display`).
2. For the image field, change its **Format** to **Protect photo Viewer**.
3. In the formatter's settings, choose whether to activate the image protection.
4. Save the display.

The deterrent then applies to that image field wherever the bundle is displayed. It
works alongside core image handling and other image‑related modules, and with Views.
