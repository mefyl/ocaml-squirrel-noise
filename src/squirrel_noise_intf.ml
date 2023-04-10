type seed = Int32.t

module type S = sig
  type t

  val noise_1d : seed:seed -> int32 -> t

  val noise_2d : seed:seed -> int32 -> int32 -> t

  val noise_3d : seed:seed -> int32 -> int32 -> int32 -> t

  val noise_4d : seed:seed -> int32 -> int32 -> int32 -> int32 -> t
end
