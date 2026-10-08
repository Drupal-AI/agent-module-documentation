# Configuration

Invite has its own settings form (route `invite.invite`) plus a set of
permissions. The most important decisions are *who* may send invitations and how
invitations behave once sent.

## Who may send invitations

Before anything else, visit **People → Permissions**
(`/admin/people/permissions`) and review the Invite permissions. Grant the
sending permission only to the roles you trust — this is the main lever that
keeps the invite system from being abused to send spam. If your site is
invite‑only, the roles that can invite effectively control who joins.

## The invite settings form

Open the Invite settings form from the admin configuration area (route
`invite.invite`). The exact fields depend on which submodules you enabled, but
in general the form lets you tune how invitations work: the messaging shown to
inviters and invitees, and how the invitation lifecycle (sent → accepted) is
handled. Adjust the wording so it matches your site's voice, and save.

## Treat invite links as capabilities

If you enabled **Invite Link**, keep in mind that a generated link is a *key* to
joining your site — anyone who receives a valid link can use it to register.
Where the submodule offers options for how long a link stays valid or whether it
can be reused, prefer settings that make links **single‑use and expiring** so a
leaked or forwarded link cannot be exploited indefinitely.

## Personal data

Invitee email addresses your users enter are personal data. Handle the stored
invitation records in line with your site's privacy policy, and clear out old
invitations you no longer need.

## Save

Click **Save configuration** when you are done. Changes take effect immediately.
