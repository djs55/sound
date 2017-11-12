open Portaudio
open Bigarray

let () =
  try
    init ();
    let device = get_default_output_device () in
    Printf.printf "Default output device is %d (%s)\n" device (get_device_info device).d_name;

    let output = Some { channels=2; device; sample_format=format_float32; latency=1. } in
    let freq = 11025. in
    let stream = open_stream ~interleaved:true None output freq 256 [] in    
    start_stream stream;
 
    let ba = Genarray.create float32 c_layout [| 256 * 2 |] in
    let sample = ref 0 in
    for j = 0 to 10000 do
        for i = 0 to 255 do
          let t = float_of_int !sample /. freq in (* seconds *)
          Genarray.set ba [| 2 * i + 0 |] (Sine.f t);
          Genarray.set ba [| 2 * i + 1 |] (Sine.f t);
          incr sample
        done;
        Portaudio.write_stream_ba stream ba 0 256
    done;

    close_stream stream
  with Error n ->
    Printf.fprintf stderr "The portaudio library failed with error: %s\n" (string_of_error n);
    exit 1