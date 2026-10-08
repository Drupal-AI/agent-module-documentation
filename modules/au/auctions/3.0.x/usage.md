<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Auctions provides auction integration for nodes, letting content be auctioned with bidding, with Commerce and mail submodules.

---

Auctions provides auction functionality for Drupal — turning nodes into auctionable items where users
place bids, with a bidding workflow, Commerce integration (`auctions_commerce`) for payment and a mail
submodule (`auctions_mail`) for notifications. It builds on an `auctions_core` submodule. This suits sites
running auctions (charity auctions, marketplaces).

Use it to run auctions on a Drupal site. The security-relevant points: bids are user-submitted data that
affect outcomes/payment, so ensure bid submission is properly access-controlled and validated (a user
shouldn't be able to place bids as another user or manipulate bid amounts), and the Commerce integration
handles the money (rely on a proper payment gateway). Verify the bidding access model and, if using
Commerce, the payment flow. Configure the auction content type and workflow.

---

- Run auctions on nodes.
- Let users place bids.
- Integrate auctions with Commerce.
- Send auction notifications.
- Build on auctions_core.
- Use auctions_commerce for payment.
- Access-control bid submission.
- Validate bids server-side.
- Prevent bidding as another user.
- Prevent bid-amount manipulation.
- Rely on a proper payment gateway.
- Verify the bidding access model.
- Configure the auction workflow.
- Run charity/marketplace auctions.
- Handle the bidding workflow.
- Notify bidders.
- Configure auction content.
- Manage bids.
- Handle auction payments.
- Secure bid handling.
