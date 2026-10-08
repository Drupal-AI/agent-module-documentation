# Configuration

Poll has **no global settings page** — the form at
`/admin/config/content/poll` is a placeholder that says "There are no settings
yet." Instead, everything is configured **per poll**, on the poll's own add/edit
form. This page walks through those per‑poll options, then the permissions that
decide who can do what, and the block you can place.

## Grant permissions first

Go to **People → Permissions** (`/admin/people/permissions`) and set who can use
Poll. The permissions are:

| Permission | Lets a user… |
|------------|--------------|
| **Administer polls** | Do everything — reach the polls overview, and create, edit, and delete any poll. (This is the master permission.) |
| **View polls** (`access polls`) | See polls and cast a vote. Required before anyone — including anonymous visitors — can vote. |
| **Access poll overview** | Reach the poll overview page. |
| **View unpublished polls** | See polls even when they're unpublished. |
| **Create polls** | Create new polls at `/poll/add`. |
| **Cancel own vote** | Cancel and recast their own vote (only works if the poll itself allows cancelling). |
| **Edit any polls** | Edit every poll. |
| **Edit own polls** | Edit only the polls they authored. |
| **Always view poll results** | See results without voting, even on polls that hide results until you've voted. |

At minimum, grant **View polls** to the roles you want to be able to vote
(including *Anonymous user* if you want visitors to vote).

## Create a poll

Go to **Content → Polls → Add poll** (`/poll/add`) and fill in the form:

### Question

The poll's question — for example "What's your favorite feature?" This is
required and becomes the poll's title.

### Choices

The answer options visitors pick from. Add as many as you like; there's no fixed
limit. Each choice also has a **weight**, which can control the order results are
shown in.

### Published

A checkbox controlling whether the poll is publicly visible at all. On by
default. Unpublish it to hide it without deleting it.

### Active

Whether the poll is **open for voting**. On by default. Turn it off to close
voting while still showing the poll and its final results.

### Poll duration

How long the poll stays open. Choose **Unlimited** (the default) to keep it open
until you close it by hand, or pick a fixed duration — anywhere from one day up
to a year — after which the poll closes itself automatically.

### Allow anonymous votes

A checkbox. Off by default. Tick it to let visitors who aren't logged in vote
(they also need the **View polls** permission). When it's on, choose a
**restriction** for how anonymous votes are limited:

- **By IP address** *(default)* — one vote per IP, a reasonable guard against
  casual ballot‑stuffing.
- **By session** — one vote per browser session, a softer limit.
- **Unlimited** — no restriction, for a casual, non‑scientific pulse check.

### Allow cancel votes

A checkbox, **on by default**. When on, a voter can cancel their vote and cast a
new one (they also need the **Cancel own vote** permission).

### Show results before voting

A checkbox. Off by default. When on, visitors see the current results before
they've voted; when off, results appear only after they cast a ballot.

### Result ordering

How the result bars are sorted: **by choice weight** (the default, so you control
the order), by **vote count ascending**, or by **vote count descending**.

### Automatic submit

A checkbox. Off by default. When on, selecting a choice submits the vote
immediately, skipping the separate submit button.

Click **Save** and the poll goes live at `/poll/{id}`.

## Place the "Most recent poll" block

Poll ships a **Most recent poll** block (`poll_recent_block`) that renders the
newest open poll in any theme region. Add it at **Structure → Block layout**
(`/admin/structure/block`): find *Most recent poll*, place it in a region such as
a sidebar, and it will always show the latest open poll — handy for a persistent
site‑wide poll.

## Managing polls

The overview at **Content → Polls** (`/admin/content/poll`) lists every poll for
editing, deletion, and moderation. Deleting a poll also removes its choices and
all of its votes.
