# Configuration

RSS Embed Field has no central settings page. You configure it on a **Link field**,
in two places on the content type: the **Manage form display** tab (how editors enter
the feed URL) and the **Manage display** tab (how the feed items are rendered).

## Step 1 — Add a Link field

1. Go to **Structure → Content types → *(your type)* → Manage fields**.
2. Click **Add field** and create a standard **Link** field (for example "News
   feed"). Save it with the default settings.

## Step 2 — Set the widget (Manage form display)

1. Open the content type's **Manage form display** tab.
2. Find your Link field and, in the **Widget** column, choose **RSS Feed**.
3. Click **Save**.

This is what lets an editor type the feed URL into the field when editing a node.

## Step 3 — Set the formatter and its options (Manage display)

1. Open the content type's **Manage display** tab.
2. In the **Format** column for your Link field, choose **RSS Feed**.
3. Click the gear/settings icon to reveal the formatter options:
   - **Number of items** — how many of the feed's most recent entries to show. Set a
     sensible cap so a long feed doesn't flood the node.
   - **Show title** — whether to display the feed channel's own heading above the
     items.
   - **Remove HTML** — how feed content is sanitised before display. This strips or
     filters the HTML that comes from each item's title and description, protecting
     against unwanted markup from the remote source.
4. Click **Update**, then **Save**.

## Step 4 — Enter a feed URL on a node

Create or edit a node of this content type, paste an RSS/Atom feed URL into the field,
and save. The module validates the URL by fetching and parsing it at save time — an
unreachable or non‑feed URL raises a form error. Once saved, the node displays the
latest items from that feed. Fetches are cached for about 24 hours to limit outbound
requests.
