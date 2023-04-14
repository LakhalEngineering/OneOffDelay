FUNCTION_BLOCK OnOffDelay
VAR_INPUT
	IN : BOOL := FALSE;
	(* Delay on tempo on. Disactive when 0 *)
	OnDelaySec : WORD := 0;
	(* Delay on tempo off. Disactive when 0 *)
	OffDelaySec : WORD := 0;

END_VAR
VAR_OUTPUT
	Q : BOOL ; (* Out signal *)
END_VAR
VAR
	TimerOn : TON;
	TimerOff : TON;
END_VAR
--------------------------------------------------------
(* On delay timer *)
TimerOn(IN:=IN, PT:=WORD_TO_TIME(OnDelaySec*1000)); (* Time * 1000 per essere en s*)

(* Set alarm Out *)
Q := TimerOn.Q;

(* Case when OnDelay Alarm is zero(0) *)
IF (OnDelaySec = 0 AND IN) THEN
	Q:= TRUE;
END_IF;

(* Off Delay timer *)
TimerOff(IN:=IN, PT:=WORD_TO_TIME(OffDelaySec*1000));

(* Set alarm Out *)
IF TimerOff.Q AND NOT IN THEN
	Q:= TRUE;
END_IF;

(* Case when OnDelay Alarm is zero(0) *)
IF(OffDelaySec=0 AND NOT IN) THEN
	Q:= FALSE;
END_IF;
