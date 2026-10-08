# Configuration

Configuration happens in two places: placing and setting up the block, and
(optionally) tuning the rate limiting. The block is the required part; the rate
limiting has a sensible default and only needs attention if you want to change it.

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Choose the region where you want the contact form and click **Place block**.
3. Find **Contact Block AJAX** and place it.
4. In the block's settings:
   - **Select the contact form** the block should display (any of your core
     contact forms).
   - **Choose the display mode** for the form. The module supports multiple forms
     with custom display modes, so you can place more than one block if you need
     different forms in different regions.
5. Save the block, then save the block layout.

Because the form loads lazily, it will only be fetched once the block scrolls into
the visitor's viewport — so place it where that behavior makes sense (further down
a long page is the ideal case).

## Rate limiting

The module protects the form-load endpoint against abuse with IP-based rate
limiting built on Drupal's Flood API. Tune it at **Configuration → People → Form
load rate limit**.

- **Request threshold** — how many requests are allowed within the time window.
  Configurable from **1 to 500**; the default is **30**.
- **Time window** — the period the threshold applies over. Configurable from **1
  minute to 24 hours**; the default is **5 minutes**.

So out of the box a single IP may load the form up to 30 times per 5 minutes.
Raise the limits for busy, legitimate traffic; lower them to clamp down harder on
abuse. Violations are logged, so you can review them in Drupal's log messages.

## Anti-spam integrations

If you use CAPTCHA, Image CAPTCHA, reCAPTCHA (v2 or v3), or Honeypot, they work
with this block's forms — configure them in their own modules as usual. The block
also cooperates with the Flood Control module. One compatibility note from the
project: when used alongside the Contact AJAX module, every mode works **except**
its "Default message and empty form" mode.

## Save

Block settings take effect as soon as you save the block and the layout;
rate-limit changes take effect when you save that settings form. Reload a page
with the block to confirm the new behavior.
