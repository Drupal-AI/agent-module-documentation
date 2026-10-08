# Configuration

There are two parts to setting this module up: granting the right **permissions**
so people can send and respond to invitations, and customising the **invitation
emails** that go out.

## Permissions

Go to **People → Permissions** (`/admin/people/permissions`) and grant these as
appropriate:

- **Use private messaging system** — a Private Message core permission. A user
  needs this (plus the one below) to reach the invite form on a thread.
- **Invite members private messaging thread** — allows a user to send
  invitations from a thread's *Invite Members* action link. Give this to the
  roles you trust to grow a conversation.
- **View Invitations** — needed to view, accept, and decline invitations. Grant
  it to the roles who will be receiving invites (typically authenticated users).
- **Administer private message module** — required to edit the invitation email
  templates (below). Keep this to administrators.

You can also grant a permission from the command line, for example:

```bash
drush role:perm:add authenticated 'invite members private messaging thread'
```

## The invitation emails

Go to **Configuration → Private Message → Invite Email Configurations**
(`/admin/config/private-message/invite`). This form lets you edit the content of
the invitation emails. The module can send different wording depending on whether
the invited address already belongs to a registered user or is a new person, so
you can tailor each message — for example, pointing new recipients at your
registration page while telling existing users they can simply log in and accept.

Edit the subject and body text to match your site's voice, then save.

## A note on who can do what

The accept and decline links are not open to just anyone holding the link: a
custom access check permits only the **invited user** (while they aren't yet a
member of the thread) or the **person who created the invitation**. Everyone else
is refused, and anonymous visitors never match — so an invitation can't be
accepted by a stranger who happens across the URL.
