# Configuration

Setting up a subsite has two parts: preparing a content type to be
subsite-enabled, then creating the subsite itself on a node. Because Sub Site is
field-based, the configuration for each subsite lives on its home node and follows
your normal content workflow.

## 1. Configure the module defaults

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Structure → Sub Site settings** (`/admin/structure/subsite/settings`).
3. Choose which content types are allowed to act as subsites, along with any
   defaults you want.

## 2. Add the Subsite field to a content type

Any content type can become subsite-enabled by adding a **Subsite** field to it:

1. Go to the content type's **Manage fields** and add the *Subsite* field.
2. On both **Manage form display** and **Manage display**, set the Subsite field to
   **hidden** — its interface is presented through the node settings panel rather
   than as an ordinary field widget, so you do not want it rendered directly.

## 3. Create a single-page subsite

Create or edit a node of a subsite-enabled type. In the node settings panel you
will find a **Subsite** section (visible to users with *Administer subsite
configuration*, or *maintain subsite* for allowed content types). There you can turn
the node into a subsite and set its overrides — theme, branding, and social links.

## 4. Create a multi-page subsite with Book

For a subsite that spans several pages, use core's Book module:

1. Make sure **Book** is enabled and configured to allow your subsite content
   type(s) in book outlines (Book's *Content types allowed in book outlines*
   setting).
2. The subsite "home page" node must be the **top-level page of a book** — if it is
   not already, choose **Create a new book** in the *Book outline* vertical tab on
   the node edit page.
3. Add sub-pages as **child pages** of that book. Child pages can be of any content
   type. The book hierarchy becomes the subsite's page tree, and Sub Site can render
   the book navigation as the subsite's main menu.

## What the override plugins do

Each subsite can combine these built-in overrides:

- **Theme** — select any enabled theme; a theme negotiator switches the active
  theme automatically as visitors browse inside the subsite.
- **Branding** — override the site name, logo, favicon, and similar branding.
- **Book** — use a book hierarchy for the page tree and override the main-menu
  navigation.
- **Social media** — override social-media links for the subsite (via Social Media
  Links).

## Blocks

Sub Site provides blocks you can place in your theme's regions for a subsite:

- **Subsite social links** — the subsite's social-media links.
- **Subsite footer links** — footer links for the subsite.
- **Book main navigation** — the subsite's book-based navigation menu.

Place these from **Structure → Block layout** as you would any block.

## Managing subsites and permissions

- The overview at **Structure → Sub Site** (`/admin/structure/subsite`) lists all
  existing subsites.
- Grant **maintain subsite** to editors who should manage subsites on the allowed
  content types, and reserve the broader administration permissions for trusted
  roles. All Sub Site routes are permission-gated — there are no anonymous or public
  mutating endpoints.
