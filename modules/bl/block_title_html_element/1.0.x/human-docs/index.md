# Block Title HTML Element — manual setup guide

**Block Title HTML Element** (`block_title_html_element`) lets administrators
choose which **HTML element wraps a block's title** — picked from a safe, fixed
list. This helps you keep block titles semantically correct: use a proper heading
level where it belongs, or a non-heading element like `span` or `p` where a
heading tag would be wrong.

The module adds a **Block Title HTML Element** selector to the block configuration
form (shown only to users with the *Administer block title element* permission)
and stores your choice as a block third-party setting. The allowed elements are a
deliberate allowlist — `h2, h3, h4, h5, h6, span, p, em, b, i`. `h1` is
intentionally left out to protect document hierarchy and SEO. Other modules can
extend the list through an alter hook if needed.

Safety is built in: the value is validated against the allowlist on the server
when the block is saved, and any invalid or empty value is discarded (the block
falls back to the theme default). Combined with the fact that only trusted admins
can set it, there's no room for arbitrary markup or script injection. To render
the chosen element, a theme's `block.html.twig` uses the `title_element` variable,
which defaults to `strong`. The module depends only on core's Block module,
requires PHP 8.1, and supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no page of its own. The **Block Title HTML Element** selector
appears on each block's configuration form under **Structure → Block layout**
(`/admin/structure/block`), for users who hold the required permission.

## How to use it

1. Grant the **Administer block title element** permission at
   **People → Permissions** to the roles that should choose title elements.
2. Go to **Structure → Block layout** and configure a block.
3. Open the **Block Title HTML Element** section and choose an element — an
   `h2`–`h6` heading, a `span`/`p` for a non-heading title, or `em`/`b`/`i` for
   emphasis. Save the block.
4. Make sure your theme's `block.html.twig` honours the `title_element` variable
   (it defaults to `strong` when no choice is made).
