# Configuration

Setting up Friendship is mostly about two things: putting the follow/unfollow control
where users can see it, and deciding what the control's text says. After that you can
surface friendship counts and links through Views.

## 1. Place the friendship link on user profiles

So that visitors can follow or unfollow someone from a user's profile page:

1. Go to **People → Account settings → Manage display**
   (`/admin/config/people/accounts/display`).
2. Move the **Friendship link** field out of *Disabled* into the visible region and
   arrange it where you want it.
3. Save. The follow/unfollow control now appears on user profile pages.

## 2. Customize the action labels

The wording of the buttons is configurable:

1. Go to **Configuration → People → Friendship settings**
   (`/admin/config/people/friendship-settings`).
2. Adjust the label text for actions such as **Follow**, **Unfollow**, and the other
   friendship states, so they match your site's voice (for example "Add friend"
   instead of "Follow").
3. Save.

## 3. Use the Views fields

Friendship exposes several fields you can add to any View — a members directory, a
profile, a leaderboard, and so on:

- **Total friends number** — how many mutual friends a user has.
- **Total followers number** — how many users follow this user.
- **Total following number** — how many users this user follows.
- **Friendship action link** — renders the correct follow/unfollow/accept/remove
  control for the current viewer relative to the listed user.

Add these from a View's **Add field** dialog (**Structure → Views**), the same way you
add any other user field.

## Permissions and privacy

Friendship provides its own **permissions** — grant the friend‑management permissions
at **People → Permissions** (`/admin/people/permissions`) to the roles that should be
able to form and manage connections.

Because friend lists and connection counts are **personal, social data**, decide
deliberately how visible they should be. Only expose friend lists and the counts
above to the extent your site's privacy expectations allow. And remember that a
friendship is not a content‑access grant on its own: forming a friendship does not, by
itself, give a user access to any protected content unless another module is
specifically built to use these relationships that way.
