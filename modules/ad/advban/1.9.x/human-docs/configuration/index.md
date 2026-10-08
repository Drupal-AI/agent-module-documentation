# Configuration

Advanced Ban has two parts you interact with: the **ban list and add-ban form**,
where you manage individual bans day to day, and the **Settings form**, where
you set defaults, the protected IP list and the messages banned visitors see.
Both live under **Configuration → People → Advanced Ban**
(`/admin/config/people/advban`) and require the **Ban IP addresses** permission.

## Adding a ban

On the main **Advanced Ban** page, fill in the add-ban form:

- **IP address** *(required)* — the address to ban. To ban a single visitor,
  this is all you need.
- **IP address (end of range)** *(optional)* — fill this in as well to ban a
  whole IPv4 range from the first field's address up to this one. Ranges are
  **IPv4 only**.
- **IP ban expiry duration** — a select list of durations (see the Settings
  section below). Choose *never* for a permanent ban, or a duration like *+1
  day* to have the ban lift itself automatically.
- **IP ban reason** — a free-text note explaining why the address was banned,
  handy for later auditing.

Click **Add** to save. The form will refuse an invalid IP, an address that is
already banned, your own current IP (including if it falls inside a range you
are trying to ban), an end address lower than the start, a non-IPv4 range, and
any address covered by the protected list.

## Managing existing bans

The ban list on the same page shows each ban with its status — **Active**,
**Expired** or **Protected** — and links to **edit** or **delete** it. Two more
tabs help with larger jobs:

- **Search** (`/admin/config/people/advban/search`) — look up a specific IP and
  find out whether it is banned, including which range ban covers it.
- **Delete all** (`/admin/config/people/advban/delete_all`) — bulk-delete bans.
  You can narrow it to all bans, only single bans or only range bans, and to
  all, only expired or only not-yet-expired bans.

## The Settings form

Go to the **Settings** tab (`/admin/config/people/advban/settings`) to set
site-wide defaults and behaviour.

### Expiry durations

The list of durations offered in the "expiry duration" select. Each line is a
free-form duration string that PHP's `strtotime()` understands — the defaults
are `+1 hour`, `+1 day`, `+1 week`, `+1 month` and `+1 year`. Add or change
lines to offer your own durations; the form validates each line and rejects
duplicates. A *never* option (a permanent ban) is always appended automatically.

### Default expiry duration

Which of the above durations is pre-selected when you add a new ban. Set this to
your most common choice so admins do not have to pick one every time. The
default is *never*.

### Remember the last duration used

A checkbox that, when ticked, makes the add-ban form default to whichever
duration you last used, instead of the fixed default above.

### Rows per page in the ban list

How many bans to show per page in the list before a pager appears. Set it to
`-1` to disable paging and show every ban on one page.

### Range display format

Controls how a range ban is printed in the list, using the placeholders
`@ip_start` and `@ip_end` — for example `@ip_start ... @ip_end`.

### Ban messages

Two text templates for the `403` page a banned visitor sees:

- **Ban text** — the message for a permanent ban. Use the `@ip` placeholder to
  include the offending address, e.g. `@ip has been banned`.
- **Ban expiry text** — the message for a ban that expires, which can also use
  `@expiry_date` to tell the visitor when the ban lifts, e.g. `@ip has been
  banned up to @expiry_date`.

### Protected IPs

A newline-separated allow-list of addresses that can **never** be banned — a
protected match always beats a ban. Each line can be:

- A single IPv4 address, e.g. `203.0.113.9`.
- A CIDR block, e.g. `198.51.100.0/24` for a partner network.
- A reverse-DNS host suffix, e.g. `googlebot.com`, to allow-list a crawler by
  the name its IP resolves to.
- A comment: a whole line starting with `#`, or a trailing `# note` after an
  entry.

Use this to protect your office, your monitoring service or trusted crawlers so
they cannot be locked out by accident.

## Save

Click **Save configuration** at the bottom of the Settings form. Changes take
effect immediately on the next request.
