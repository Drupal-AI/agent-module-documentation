# Font Awesome — manual setup guide

**Font Awesome** (`font_awesome`) integrates Drupal with Font Awesome, the
popular icon toolkit, so content editors can attach an icon to almost anything.
Rather than defining a special "icon" field type, this module works with
ordinary plain-text (`string`) fields: a text field stores an icon class such as
`fas fa-eye`, and the module supplies a visual **icon-picker widget** for
choosing it and an **icon formatter** for rendering it as an `<i>` element on the
page. That keeps your data simple (just class names) while giving editors a
friendly picker instead of asking them to memorise class names.

The module does not bundle the Font Awesome font itself. The actual assets — the
CSS/JS or SVG, whether they load from a CDN or locally, which version, and
minification — are delivered by the required **`lp_fontawesome`** module (built
on Libraries Provider), and those choices are made there. The formatter attaches
the Font Awesome library only on pages where an icon field actually renders, so
you are not loading the icon font everywhere.

All configuration is **per field**, done through Drupal's normal display
screens — there is no global settings page for this module. You add a plain text
field, give it an icon-picker widget on the form, and give it the icon formatter
on the display. The steps are below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (the `lp_fontawesome` library module is required).

## Where it lives in the admin menu

Nowhere of its own — there is no dedicated settings page and no permissions. You
configure icons per field through **Manage form display** and **Manage display**
on each content type. (Font Awesome library settings live under the separate
`lp_fontawesome` module.)

## How to use it

1. Enable this module and its required `lp_fontawesome` dependency (see
   [Installation](installation/index.md)).
2. On a content type, add a plain **Text (plain)** field — a core `string`
   field. This is where the icon class will be stored. (You can also do this on a
   taxonomy term, user, or any fieldable entity.)
3. On **Manage form display**, set that field's widget to **Font Awesome icon
   picker**. This gives editors a visual picker instead of a plain text box.
   (There is also a "Font Awesome icon picker (LEGACY)" widget, which lets you set
   a default icon such as `fas fa-eye`; prefer the current picker for new fields.)
4. On **Manage display**, set the field's format to **Icon** (the
   `font_awesome_icon` formatter). Its options let you:
   - choose a **size** class from `fa-xs` up to `fa-10x` (or none), and
   - toggle the **fixed-width** class `fa-fw` (on by default), which keeps icons
     neatly aligned in lists.
   - You can also render the icon as a link to its host entity.
5. Editors now pick an icon when editing content, and it renders at the chosen
   size wherever the field is displayed.

The same string field can even use a plain text widget in one form mode and the
icon picker in another, and icon data migrates as simple class-name strings.
