# Background Slider — manual setup guide

**Background Slider** (module `background_slider`, project `background_sliders`) puts a
full‑page **background slideshow** behind your page content — a rotation of images, or a
looping video, ideal for a hero or landing‑page backdrop. You build the slideshow
slide‑by‑slide on a settings form and display it by placing the module's **block** in a
region. It runs on Drupal 9.4 and 10.

You choose how many slides there are and whether the slider shows **images** (gif, png,
jpg, jpeg, webp) or **video** (mp4, m4v, mov, flv, ogg, webm and more), then upload each
slide's media through a managed‑file widget. Uploaded files are marked permanent on
save; images are stored under `public://bk-imgs` and videos under `public://bk-videos`.

Because it's a single settings form plus a block, the setup is described here rather
than in a separate configuration page.

> ## ⚠️ Access‑control note
>
> The settings route (`background_slider.settings`) is gated only by the
> `authenticated` role — **not** by an administrator permission. That means **any
> logged‑in user**, not just administrators, can open the form, change the slider
> configuration and upload image/video files. If your site allows open registration or
> has many low‑trust accounts, treat this as a real risk: restrict registration, or
> patch the route to require an admin permission, before relying on the module. (The
> module does define an `access configuration form` permission, but the route uses the
> role check instead of it.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

The slideshow is built on the module's settings form (route
`background_slider.settings`), and displayed by placing its block from **Structure →
Block layout** (`/admin/structure/block`).

## How to use it

1. Open the settings form and choose the **number of slides** and the **slider type**
   (image or video). Switching the type swaps the upload fields via an AJAX callback.
2. **Upload each slide's media** through the managed‑file widget — only the allowed
   extensions for the chosen type are accepted.
3. Save. The configuration is stored in `background_slider.setting`, and uploaded files
   are marked permanent.
4. Go to **Structure → Block layout** and place the slider block in a region — usually a
   header or full‑width region so it sits behind the page content.

Once the block is placed, the slideshow rotates behind your content on every page where
the block appears, with its CSS/JS attached automatically.
