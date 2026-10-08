# AJAX Cart Update — manual setup guide

**AJAX Cart Update** (`ajax_cart_update`) adds AJAX to the Drupal Commerce cart
form so quantities and order totals update in place, without a full page reload.
Change a line item's quantity and the totals recalculate right away, for a
smoother, more modern cart experience.

It is a small, focused UX enhancement. It does not replace or bypass any of
Commerce's own logic — cart operations still go through Commerce's normal
handling and access checks. Because the Commerce cart form is built as a View,
the module depends on core's **Views** module. It has no access-control role of
its own and no settings to configure.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to configure. Once the module is enabled, the Commerce cart
form updates its line-item quantities and order totals via AJAX automatically —
customers no longer wait for a full page reload after changing a quantity. The
cart's underlying behavior (pricing, availability, access) is unchanged; only
the way updates are applied to the page becomes dynamic.
