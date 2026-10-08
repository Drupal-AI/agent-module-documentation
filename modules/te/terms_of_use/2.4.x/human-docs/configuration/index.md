# Configuration

## Open the settings form

1. Log in as a user with the **Administer account settings** permission.
2. Go to **Configuration → People → Terms of Use**, or navigate directly to
   `/admin/config/people/terms-of-use`.

## Settings

| Field | What it does |
|-------|--------------|
| **Terms of Use node** | The node whose content is your terms and conditions. This is a required node autocomplete — start typing the title and pick it. Update your terms later by simply editing this node. |
| **Fieldset label** | The title of the collapsible section that wraps the terms and the checkbox on the registration form. Leave it empty and the section is still there, just without a title. |
| **Checkbox label** | The label of the required "I agree" checkbox. If you include the `@link` token here, it is replaced by a link to the terms node (and the full body text is not shown). For example: `I agree with the @link.` |
| **Open link in new window** | Only relevant when the checkbox label uses the `@link` token — opens the terms link in a new browser tab/window. |
| **Collapsed by default** | If ticked, the terms section starts collapsed; if unticked, it starts open. |

The fieldset label and checkbox label are translatable through Drupal's configuration
translation, so you can localise them per language.

## How it appears on the registration form

- The terms and checkbox are injected into the registration form
  (`/user/register`) inside a collapsible **details** element titled with your
  fieldset label.
- **If the checkbox label contains `@link`:** a link to the terms node is shown (in a
  new tab when you enabled that option), and the full terms text is *not* displayed.
- **Otherwise:** the terms node's body is shown inline. The checkbox is **required**,
  so registration cannot complete until the visitor ticks it.
- **Administrators are skipped:** users with the *Administer users* permission (for
  example an admin creating an account at **People → Add user**) never see the terms —
  it only blocks public self-registration.
- If the terms node has a translation for the visitor's current interface language,
  that translation is shown.

## Setup checklist

1. **Create the terms node.** Add a page (any node type works) containing your terms
   and conditions text. It is common to leave it unpublished from the front page /
   not promoted; it just needs to exist for the module to read.
2. **Allow public registration.** In core, go to **Configuration → People → Account
   settings** and set *Who can register accounts?* to **Visitors** (or *Visitors, but
   administrator approval is required*), otherwise there is no public form to add the
   checkbox to.
3. **Configure this module.** On the Terms of Use settings page, choose your terms
   node and set the fieldset title and checkbox label (add `@link` if you want a link
   rather than inline text).
4. **Clear the cache** and visit `/user/register` — the required agreement checkbox
   now appears.
