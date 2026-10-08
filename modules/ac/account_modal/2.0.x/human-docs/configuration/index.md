# Configuration

Account Modal has a small settings form where you control which account links open
as a modal dialog rather than as a full page.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Open the Account Modal settings form (`account_modal.admin_settings`). You can
   reach it from the site's configuration pages, or find it by name on the
   **Extend** / configuration listing.

## Choose which links open in a modal

The form lets you turn the modal behaviour on for the account links the module
supports — **login**, **register** and **password reset**. Enable the ones you want
presented as a dialog and leave the rest to behave as normal page links.

Whatever you choose here is presentation only: the forms shown in the modal are the
standard Drupal account forms and continue to enforce the same authentication and
access rules they would on their own pages.

## Save

Click **Save configuration**. The selected account links now open in a modal for
your visitors.
