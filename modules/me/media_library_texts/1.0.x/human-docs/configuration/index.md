# Configuration

All of this module's behavior comes from a single settings form, where you enter the
wording you'd like the Media Library widget to use instead of Drupal core's
defaults.

## Open the settings form

1. Log in as a user with permission to administer the Media Library texts (grant the
   module's permission on **People → Permissions** if needed).
2. Go to the module's settings form in the **Configuration → Media** area — you can
   also reach it via the module's **Configure** link on the **Extend** page
   (`/admin/modules`).

## Enter your replacement texts

The form presents the Media Library widget's text strings — such as the **"Add
media"** button label, along with the widget's other labels, help text, and
empty‑state messages — each with a field where you type your own wording. For
example, to make an image‑only field read more naturally you might replace **"Add
media"** with **"Add image"**.

Leave a field at its default (or empty, per the form's guidance) to keep core's
original text for that string. Only the strings you actually change are overridden.

## Save

Click **Save configuration**. Your wording takes effect immediately — open a Media
Library widget from any media field to confirm the new text appears. If it doesn't
update right away, clear caches.

> **Tip — translations:** because this simply changes the widget's text, it's a
> convenient way to set consistent, on‑brand wording. If your site is multilingual,
> handle per‑language wording through Drupal's usual translation tools in addition to
> the text you set here.
