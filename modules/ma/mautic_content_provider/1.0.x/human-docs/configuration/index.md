# Configuration

Configuration is where you decide **what** Drupal content is made available to
Mautic, and in what form. There are two parts: the settings form (which nodes and
view modes to expose) and an optional Mautic‑specific Views display.

## Open the settings form

Log in as an administrator and go to **Configuration → Web services → Mautic Content
Provider** (`/admin/config/services/mautic-content-provider`).

## Choose the content to expose

On the settings form you select:

- **Which nodes** are exposed to Mautic. Expose only the content you actually want
  Mautic to be able to pull — this is your main control over what leaves the site.
- **Which view modes** are used to render them. The chosen view mode determines how
  much of each node (which fields, which formatting) becomes part of the
  email‑friendly HTML.

## Add a Mautic Views display

The module also adds a **Views display type** built for Mautic output. On any view,
add a new display of that type to expose a curated list of content as email‑friendly
HTML — useful for "latest articles" style blocks in a Mautic campaign. Configure the
view's filters and fields as usual; the display produces the Mautic‑ready markup.

## The Mautic side

Remember that Drupal only *provides* the content. For Mautic to consume it, the
**"Drupal Integrated Content"** plugin must be enabled on your Mautic installation.
Once both sides are in place, the selected nodes and views appear as dynamic content
you can drop into Mautic email templates.

## Keep exposure appropriate

Anything you expose here is readable through the provider endpoint that Mautic uses.
Restrict the selection to content that is appropriate to publish this way, and keep
access to the endpoint suited to your setup.

## Save

Save the settings form. Your selected nodes and view modes are then available to
Mautic through the "Drupal Integrated Content" plugin.
