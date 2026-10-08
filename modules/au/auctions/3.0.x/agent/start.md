<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auctions — agent index

Provides **auction functionality for nodes** (bidding on content) with `auctions_commerce` (payment) +
`auctions_mail` (notifications), built on `auctions_core`. Version **3.0.x** (dev). Core `^11`.

**Security:** bids are user-submitted and affect outcomes/payment — ensure bid submission is
access-controlled + validated (no bidding as another user / amount manipulation); Commerce handles money
(proper gateway). Verify the bidding access model.
