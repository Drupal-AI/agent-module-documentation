# Configuration

Setting up Shared Email is two things: fill in the small settings form, and grant the
right permissions. Both matter — the settings decide *which* addresses may be shared,
and the permission decides *who* may share them.

## The settings form

Go to **Configuration → People → Shared Email**
(`/admin/config/people/shared-email`). You need the **Administer shared email**
permission. There are two fields:

- **Allowed addresses** (`sharedemail_allowed`) — a comma-separated list of email
  addresses that are permitted to be shared. **Leave it empty to allow any address**
  to be shared (by users who have the permission). If you fill it in, only listed
  addresses may be reused.
  - A subtle but useful detail: the match is a case-insensitive substring test
    against the whole list, so entering just `example.com` effectively allows *every*
    address at that domain, while `team@example.com,info@example.com` restricts
    sharing to those two exact addresses.
- **Warning message** (`sharedemail_msg`) — the text shown to a user after they save
  an account with an email that another account already uses. It ships with a long
  default that reminds the user password resets will go to that address and suggests
  using a unique one. This message is only displayed to users who hold the **Access
  shared email message** permission (see below).

Save with **Save configuration**. The settings are stored as ordinary configuration,
so you can export and deploy them across environments.

## The three permissions

On **People → Permissions** you will find:

- **Administer shared email** — access to the settings form above.
- **Create shared email account** — this is the functional switch. Only users with
  this permission can save a duplicate email address, and only when the address is
  allowlisted (or the allowlist is empty). Without it, the normal one-account-per-email
  rule is enforced as usual. Grant it to trusted admin roles; leave it off for
  self-registration so ordinary sign-ups still require unique emails.
- **Access shared email message** — purely informational: it controls whether the
  warning message is shown to a user after they save a shared address. It is not an
  access control.

## How the two work together

Think of it as a lock with two keys: the **permission** decides *who* may reuse an
email, and the **allowlist** narrows *which* emails they may reuse. To let admins
create shared accounts for a single departmental inbox, grant **Create shared email
account** to your admin role and put that one address in the allowlist. To allow any
duplicate for trusted roles, grant the permission and leave the allowlist blank.
