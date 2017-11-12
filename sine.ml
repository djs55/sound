open Common

(** f is a function from time (in seconds) to sample value in the
    range from [-1, 1] *)
let f t =
  let c = 261.625565 in (* middle C in oscillations/second *)
  sin(t *. c *. 2.0 *. pi)