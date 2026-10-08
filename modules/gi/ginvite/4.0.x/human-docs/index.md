# Group invite — manual setup guide

**Group invite** (`ginvite`) extends the **Group** module so that group managers can
invite people to join their group — either existing site users or plain email
addresses. Invitees receive an email, accept or decline from their profile, and on
acceptance become members of the group. It is the piece that turns Group from an
admins-add-everyone model into a self-service, invitation-driven one.

Invitations are added to a group type just like membership is: Group invite ships a
group **relation plugin** called **Group Invitation**, which you install on each group
type where you want invites. Once installed, you can configure the invitation emails
(separate templates for already-registered users versus brand-new invitees), a
cancellation notice, how many days an invitation stays open before it expires, whether
to auto-accept and unblock invitees when they register, and whether accepting creates
membership immediately or removes the invitation afterwards.

Group managers send invitations one at a time or in bulk from a per-group invite form,
and invitees manage them from a "My invitations" tab on their profile, accepting or
declining with a click. Each invitation tracks its status — pending, accepted,
rejected, or expired. A site-wide reminder can nudge users who have invitations
waiting. Two ready-made Views come with the module: the invitee's "My invitations"
list and a per-group list of all its invitations.

Who can do what is controlled by **group permissions** (granted per group role), not
just site permissions: invite users, bulk-invite, view invitations, delete your own or
any invitation, and fully administer invitations. So you can delegate invitation
management to group managers rather than only site administrators.

This guide is written for a **human**. For a terse, token-cheap reference aimed at an
AI coding agent — including the invitation entity fields, statuses, routes, and loader
service — read the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Group and Views.
2. [Configuration](configuration/index.md) — install the invitation relation on a
   group type, tune its email/expiry settings, the pending-invitation reminder, and
   the group permissions.

## Where it lives in the admin menu

Group invite has no single global settings page. You configure it per group type, on
that type's relation-plugin (content) settings, under **Groups** administration
(**Administration → Groups → Group types**). Members send invitations from a group's
own **Invite members** form (`/group/{group}/invite-members`), and invitees respond
from the "My invitations" tab on their user profile.
