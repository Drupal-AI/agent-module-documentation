# External Link Pop-up — manual setup guide

**External Link Pop-up** (`external_link_popup`) shows a confirmation dialog when a
visitor clicks a link that leaves your site. Instead of jumping straight to a
third-party website, the visitor sees a pop-up — "You are now leaving this site" — with
your own wording and Yes/No buttons, and only continues if they confirm. It's a common
requirement for regulated industries (finance, health, government) and for anyone who
wants an exit disclaimer on outbound links.

You define one or more **pop-ups**, each a small configuration item with its own title,
rich-text body, button labels, and a list of domains it applies to. Pop-ups are matched
in weight order and the first matching domain wins, so you can have a specific pop-up for
partner sites and a catch-all (`*`) pop-up for everything else. A global **whitelist** of
trusted domains suppresses the pop-up entirely for links you consider safe.

On the front end, clicking an external link opens a standard Drupal (jQuery UI) dialog.
You can exclude an individual link from pop-ups with a CSS class, or force a specific
pop-up onto any link — even an internal one — with a data attribute, and the JavaScript
emits events you can hook into for analytics.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — creating pop-ups, the per-pop-up fields,
   and the global settings.

## Where it lives in the admin menu

Everything sits under **Configuration → Content authoring → External Link Pop-up**:

- The **pop-up list** (add/edit/delete/enable/disable) at
  `/admin/config/content/external_link_popup`.
- The **global settings** form at
  `/admin/config/content/external_link_popup/settings`.

Both are gated by the **Administer external link popup** permission.

## How to use it

Out of the box the module ships one **default** pop-up that targets every external link
(`*`) with the title "You Are Now Leaving This Site", so pop-ups start working
immediately. From there you typically:

1. Edit the default pop-up (or add new ones) to set your own wording and button labels.
2. Add domain-specific pop-ups for particular partner or third-party sites.
3. List any trusted domains in the global settings' whitelist so they never trigger a
   pop-up.

See [Configuration](configuration/index.md) for the full field-by-field details.
