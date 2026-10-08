# Configuration

Responsive Image Style Builder has **no settings form of its own**. Instead, its
behavior is triggered when you create a **responsive image style** through
Drupal's core admin. This page walks through that flow.

## Create a responsive image style

1. Log in as a user who can administer responsive image styles (an administrator
   by default).
2. Go to **Configuration → Media → Responsive image styles**
   (`/admin/config/media/responsive-image-style`) and click **Add responsive
   image style**.
3. Give the style a **Label** (any name you like — for example "Content images").
4. Choose a **Breakpoint group**. Pick your **active theme's** breakpoint group,
   since that defines the breakpoints the module will build styles from.
5. **Save.**

## What happens on save

As soon as you save, the module inspects the breakpoint group and **automatically
creates a plain image style for every breakpoint and multiplier** in that group.
You don't have to pre‑build those styles by hand — that's the whole point of the
module.

## Confirm the generated styles

After saving, go to **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`). You should see the newly generated
styles — one for each breakpoint/multiplier combination — named after your
responsive image style. From here you can add or adjust the crop/scale **effects**
on each generated style to suit your design.

## Using the style

Once the responsive image style and its child styles exist, use the responsive
image style anywhere core supports it — most commonly by setting an image field's
**Manage display** format to **Responsive image** and selecting your style.

> **Note:** This module generates image‑style *configuration* only. It has no
> effect on who can view content — normal field and entity access still apply.
