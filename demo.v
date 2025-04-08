Require Import prelude.

(** A pure mathematical theorem and proof. *)
Lemma sqrt_2_integer_False :
  ¬(∃ x : Z, x * x = 2).
Proof.
  intros [x H].
  assert (x = -1 ∨ x = 0 ∨ x = 1) as Hcases.
  { lia. }
  lia.
Qed.
