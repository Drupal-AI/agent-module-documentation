# Configuration

Setting up Commerce Referral means defining how the programme rewards both sides —
the friend's discount and the referrer's kickback — and controlling who can take
part.

## How the flow works

1. A user visits their **referral page**, where a unique coupon code is created
   automatically.
2. They share that code with a friend.
3. The friend applies the code at checkout and receives a discount.
4. When the order is **placed or paid** (depending on your setting), a **kickback**
   coupon is created for the referrer.
5. The referrer redeems their kickback on a later order.

## Configure the programme

Working under **Commerce**, set up:

- **Referral type(s)** — the module supports multiple referral types, each mapped
  to different promotions. Create a type for each distinct offer you want to run.
- **The friend's discount** — the Commerce **promotion** applied when a referral
  code is used at checkout. Configure the discount amount and any conditions on
  that promotion.
- **The kickback reward** — the promotion/coupon issued to the referrer, and the
  reward's value.
- **When the kickback is awarded** — choose whether the referrer's reward is
  created on **order placement** or on **payment**. Choosing **payment** ties each
  kickback to confirmed payment, which is the recommended setting for most stores.
- **Who may generate referral codes** — use the configurable **conditions** to
  control which users can participate (for example, only authenticated customers).

## Permissions and abuse prevention

- Review the module's permissions at **People → Permissions** and grant them
  deliberately — rewards have monetary value.
- Keep **self-use prevention** in effect so a user cannot redeem their own referral
  code. Referral codes are visible to users, so the system validates attribution
  server-side rather than trusting the code alone; don't rely on the code for any
  security decision.

## Reporting and testing

Use the admin **referral reporting** to track successful referrals. Before going
live, test the full loop: generate a code as one user, use it as another, place
(or pay for) the order, and confirm the referrer's kickback coupon is issued and
that self-referral is blocked.
