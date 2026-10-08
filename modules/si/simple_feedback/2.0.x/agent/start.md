<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Feedback — agent index

Per-node **Yes/No 'was this helpful?'** block. Votes go to `/ajax/simple_feedback/{node}/{feedback}` and are stored (nid, uid, IP, +1/-1) in the `simple_feedback` table, deduped per node+IP; a second route returns JSON tallies. Version **2.0.0**, core 8–10.

Access: both routes require `access content` (anonymous visitors can vote). Queries parameterized (no SQLi).