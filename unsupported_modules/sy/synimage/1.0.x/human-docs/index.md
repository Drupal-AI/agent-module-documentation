# Synimage — manual setup guide

**Synimage** (`synimage`) is a WYSIWYG editor plugin that lets content editors
insert an image which opens in a Colorbox lightbox. Instead of the picture simply
sitting in the body text, a reader clicks it and a larger version pops up in a
Colorbox overlay on top of the page. It belongs to the Synapse family of modules.

The idea is to give editors a one-click way to add "click to enlarge" images from
inside the rich-text editor, without hand-writing any markup. The plugin inserts
image markup into the field, so the text format you are editing needs to allow
that markup for the image to survive filtering. The images themselves follow
Drupal's normal core file access — the module adds no access rules of its own and
plays no security or access-control role.

A note on the module's status: on drupal.org it is marked **Unsupported** and its
development status is **Obsolete**, and it is not covered by the security advisory
policy. Weigh that before adopting it on a new site. There are no other module
dependencies, and the module ships no submodules.

This guide is written for a **human** setting the module up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead — they are terser and cheaper to consume.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Synimage does not add an admin settings page. Once the module is enabled, you turn
it on where your rich-text editing happens: go to **Configuration → Content
authoring → Text formats and editors**
(`/admin/config/content/formats`), edit the text format your editors use (for
example *Full HTML*), and drag the Synimage button into the CKEditor toolbar. Make
sure that format's filters allow the image markup the plugin inserts, otherwise the
inserted image can be stripped on save. From then on, editors using that format get
a toolbar button for inserting a lightbox image that opens in Colorbox.
