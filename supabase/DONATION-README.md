# Donation setup

The website displays the user-supplied QR image unchanged and UPI ID 9164399231@hdfc. The UPI app completes payment. Scanning the static QR requires entering the amount in that app; the Open UPI app link includes the selected amount. No payment is automatically marked successful.

Run `donation-proofs.sql` in Supabase SQL Editor after the existing admin setup. It is also included in the updated `admin-all-in-one.sql`. No additional public environment values or service-role key are required. Until this migration is run, the site shows WhatsApp as the proof-submission fallback.

The migration adds a private `donation-proofs` Storage bucket (JPG/PNG/WebP, 5 MB) and `donation_submissions` table. Visitors can upload a new screenshot and submit an insert-only request through a constrained RPC. Visitors cannot read submissions, list/download proofs, overwrite files, mark payments verified or edit submitted details. UUID receipt references make retries idempotent; retrying never resets an admin review.

Open `/admin/donations/` with a trusted administrator account. Review the screenshot using a temporary signed URL, check bank/UPI records independently, then mark verified or reject with a reason. Proofs are never shown in the gallery. The downloadable donor acknowledgement confirms evidence submission only, not payment or tax eligibility.

If the upload succeeds but saving the request fails, retry without changing the selected file. The client reuses that private upload. Abandoned uploads remain private and can be reviewed in Storage Dashboard.

QR verification: the attached QR decodes to `upi://pay?ver=01&mode=01&purpose=00&mc=0000&qrMedium=02&pa=9164399231@hdfc&pn=RAASAA KA AND KALA SAMSKRUTI CT`. Its recipient address matches the printed UPI ID. The app link uses this same address and name. No test payment has been made.

Retry safety: the same receipt UUID accepts an identical retry only. Different details are rejected without changing the original record or its review status.
