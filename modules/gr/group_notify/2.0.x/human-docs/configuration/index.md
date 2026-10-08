# Configuration

Group Notify has no central settings form. Instead, you enable notifications on
each **Group Node content plugin** for the group types where you want members
emailed about new content.

## Turn on notifications for a group content type

1. Log in as a user who can administer group types.
2. Go to **Administration → Groups → Group types**, and choose the group type you
   want.
3. Open its **Set available content** page (the list of content plugins available
   to that group type).
4. Find a plugin provided by **Group Node** (`gnode`) — for example the group node
   type you use for pages, articles, or documents.
5. Click **Install** (if it is not yet installed) or **Configure** (if it is), and
   in the plugin's settings tick **Notify group members**.
6. Save.

Repeat for each group content type that should trigger emails.

From now on, when someone saves that kind of content inside a group, its members
receive an email.

## Things to decide as you configure

- **Which content types actually warrant an email.** Turning it on for every
  plugin quickly becomes noise. Enable it only where a new item is genuinely
  something members should be told about.
- **Whether every member should get every item.** On active groups, a message per
  item trains people to ignore it. Consider whether a digest or a per-member
  frequency fits your community better before enabling it broadly.
- **Whether recipients can open what you announce.** Group Notify composes the
  email when the content is saved, while access is checked when it is read, so
  make sure the members you notify can actually reach the content.
- **How much the email should contain.** Prefer a subject line and a link back to
  the site over embedding the content itself, so group-restricted material is not
  delivered into arbitrary (possibly shared) mailboxes.

## Performance note

If a group has many members and saving content becomes slow, enable the
`queue_mail` module (see [Installation](../installation/index.md)) to move the
email sending into a queue.
