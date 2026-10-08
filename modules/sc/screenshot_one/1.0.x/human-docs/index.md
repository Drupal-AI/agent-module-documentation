# Screenshot One — manual setup guide

**Screenshot One** (`screenshot_one`) captures screenshots of web pages using the
external [ScreenshotOne](https://screenshotone.com/) service and brings the results
into Drupal. It offers two things: a **service** that any other module can call to
turn a URL into a screenshot, and two **AI Automator types** (for the AI Automator
submodule of the [AI module](https://www.drupal.org/project/ai)) that take a link
field and automatically produce an **Image** or **Media Image** field from it. It
is the successor to the older *AI Interpolator Screenshot* module, which it makes
obsolete.

It can remove cookie banners automatically, capture the full page rather than just
what is above the fold, or capture the exact dimensions you specify. Because the
page is fetched by ScreenshotOne's own servers and not by your Drupal site, there
is **no server-side request forgery (SSRF) risk** on your end. The service requires
a ScreenshotOne account (you can test 100 screenshots for free), and your API and
secret keys are stored securely via the **Key** module. The settings form is gated
by the *Administer site configuration* permission. Screenshot One depends on the
**Key** module and supports **Drupal 10.3+ and 11**.

To actually generate screenshots you need a consumer of the service — currently
that means the **AI Automator** submodule of the AI module. On its own, Screenshot
One provides the service and the automators; something has to call them.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module.
2. [Configuration](configuration/index.md) — adding your API keys and wiring up the
   AI Automator to fill an image field from a link.

## Where it lives in the admin menu

Its settings form — where you enter your ScreenshotOne API and secret keys — is at
`/admin/config/screenshot-one/settings`, and requires the *Administer site
configuration* permission.
