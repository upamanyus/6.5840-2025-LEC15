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

Section proof.
Context `{hG: heapGS Σ, !ffi_semantics _ _}.

Lemma boring_spec :
  ❴ True ❵
    #() ;; #(W64 10)
  ❴ returns (W64 10); True ❵.
Proof.
  wp_start as "Hpre".
  wp_auto. iApply "HΦ". done.
Qed.

End proof.
