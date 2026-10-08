# Configuration

Crisis mode is best set up **before** you ever need it: write and save your message
in advance so that, when an emergency arrives, activating it is a single click. This
page covers both writing the message and the two ways to turn it on and off.

## Open the settings form

1. Log in as a user with permission to administer Crisis mode (an administrator by
   default).
2. Go to **Configuration → System → Crisis mode**, or navigate directly to
   `/admin/config/system/crisis_mode`.

## Configure the message

On the settings page you prepare the content that the crisis block will show when it
is active:

- **Crisis title** — the heading of the message.
- **Crisis text** — the body of the announcement. This is what visitors see on every
  page while the crisis is active.
- **Link to more information** *(optional)* — a URL pointing to a page with fuller
  details, for visitors who want to read more.

Fill these in and click **Save** — saving also clears caches. With the message saved
but the crisis situation left inactive, nothing is shown to visitors yet. You are now
ready to activate at a moment's notice.

## Activate the crisis situation

When you need to broadcast the message, you have two options, and both make the block
visible everywhere and clear caches:

- **From the settings page** — tick the **Crisis Situation** checkbox and click
  **Save**.
- **From the command line** — run `drush crisis-mode on`.

## Deactivate it again

When the crisis is over, stand the message down the same two ways:

- **From the settings page** — untick the **Crisis Situation** checkbox and click
  **Save**.
- **From the command line** — run `drush crisis-mode off`.

## Operational tip

Because activating or deactivating the block shows or hides a message on every page
and clears caches, treat it as a deliberate, high-visibility action. Prepare the
message text ahead of time, decide who is responsible for flipping the switch, and
make sure they know both routes (the checkbox and the Drush command) so the site can
respond quickly whether or not they have admin-UI access at the moment.
