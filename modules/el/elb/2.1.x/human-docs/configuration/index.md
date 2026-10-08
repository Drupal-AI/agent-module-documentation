# Configuration

Setting up External Link Blocklist has two parts: turn on validation for the link
fields you care about (by choosing its widget), and maintain the list of blocked
patterns.

## Enable validation on a Link field

1. Go to the entity's field settings — for example **Structure → Content types →
   *(your type)* → Manage form display**.
2. For the **Link** field you want to protect, choose the **External link blocklist**
   widget.
3. (Optional) The widget's settings gear exposes **size** and **placeholder** for the
   field, the same as the standard link widget.
4. Save.

Repeat for any other link fields that should enforce the blocklist — the same
central blocklist applies to all of them.

## Edit the blocklist

1. Log in as a user with the **Access the external links blocklist page**
   permission.
2. Go to **Configuration → Content authoring → External Link Blocklist**
   (`/admin/config/content/elb`).
3. Fill in the two fields:
   - **Blocklist** — a comma-separated list of forbidden URL patterns, for example
     `dev.example.com, staging.example.net`. When an editor enters a link whose URL
     contains any of these patterns, they get a validation error.
   - **Exceptions** — a comma-separated list of patterns that override the blocklist.
     For example, block `example.com` but list `good.example.com` as an exception so
     that one subdomain is still allowed.
4. Save.

Both values are stored as single comma-separated strings and split on commas
(whitespace is trimmed and empty entries dropped), so you can update the policy
centrally here without touching individual field configuration.

## How matching works

Matching is **plain substring containment**, not domain parsing. A link is blocked
when its URL *contains* any blocklist pattern and *does not contain* any exception
pattern. Because it matches anywhere in the string, a pattern like `example.com`
matches `https://sub.example.com/page` and `https://example.com.evil.test` alike —
so choose patterns carefully and specifically. This substring approach is a
deliberate simplicity, not a security boundary.

## Linkit integration

If the Linkit module is installed, the same blocklist is applied to the Linkit
CKEditor link dialog — a validator is added to the dialog's link (href) element, so
blocklisted links are rejected there too, not just in the field widget.

## Upgrade caution

When you update this module, its update hook **grants the "Access the external links
blocklist page" permission to every role that already has "Access administration
pages."** After running database updates, review your roles at **People →
Permissions** and confirm that only the roles you intend can reach
`/admin/config/content/elb`.
