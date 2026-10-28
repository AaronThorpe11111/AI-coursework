

(define (domain lunar)

    (:requirements :strips :typing)

    (:types
        rover
        lander
        waypoint
        data
        sample
    )

    (:predicates

        ; Locations
        (at-rover ?r - rover ?w - waypoint)
        (at-lander ?l - lander ?w - waypoint)

        ; Deployment state
        (aboard ?r - rover ?l - lander)
        (deployed ?r - rover)

        ; Rover ownership
        (assigned ?r - rover ?l - lander)

        ; Map connections
        (connected ?from - waypoint ?to - waypoint)

        ; Data collection sites
        (image-site ?d - data ?w - waypoint)
        (scan-site ?d - data ?w - waypoint)

        ; Sample locations
        (sample-site ?s - sample ?w - waypoint)

        ; Rover memory
        (memory-free ?r - rover)
        (has-data ?r - rover ?d - data)
        (transmitted ?d - data ?l - lander)

        ; Sample handling
        (sample-space-free ?r - rover)
        (carrying-sample ?r - rover ?s - sample)

        ; Lander storage
        (lander-space-free ?l - lander)
        (sample-stored ?s - sample ?l - lander)
    )

 ; Action for deploying the rovers
    (:action deploy

        :parameters (?r - rover ?l - lander ?w - waypoint)

        :precondition
            (and
                (assigned ?r ?l)
                (aboard ?r ?l)
                (at-lander ?l ?w)
            )

        :effect
            (and
                (deployed ?r)
                (at-rover ?r ?w)
                (not (aboard ?r ?l))
            )
    )
 ; Action for moving the rovers
    (:action move

        :parameters (?r - rover ?from - waypoint ?to - waypoint)

        :precondition
            (and
                (deployed ?r)
                (at-rover ?r ?from)
                (connected ?from ?to)
            )

        :effect
            (and
                (not (at-rover ?r ?from))
                (at-rover ?r ?to)
            )
    )
 ; Action for capturing images
    (:action capture-image

        :parameters (?r - rover ?d - data ?w - waypoint)

        :precondition
            (and
                (at-rover ?r ?w)
                (image-site ?d ?w)
                (memory-free ?r)
            )

        :effect
            (and
                (has-data ?r ?d)
                (not (memory-free ?r))
            )
    )
 ; Actions for performing scans
    (:action perform-scan

        :parameters (?r - rover ?d - data ?w - waypoint)

        :precondition
            (and
                (at-rover ?r ?w)
                (scan-site ?d ?w)
                (memory-free ?r)
            )

        :effect
            (and
                (has-data ?r ?d)
                (not (memory-free ?r))
            )
    )
; Action for transmitting data
    (:action transmit-data

        :parameters (?r - rover ?d - data ?l - lander)

        :precondition
            (and
                (assigned ?r ?l)
                (has-data ?r ?d)
            )

        :effect
            (and
                (transmitted ?d ?l)
                (memory-free ?r)

                (not (has-data ?r ?d))
            )
    )
 ; Action for collecting the samples
    (:action collect-sample

        :parameters (?r - rover ?s - sample ?w - waypoint)

        :precondition
            (and
                (at-rover ?r ?w)
                (sample-site ?s ?w)
                (sample-space-free ?r)
            )

        :effect
            (and
                (carrying-sample ?r ?s)

                (not (sample-space-free ?r))
                (not (sample-site ?s ?w))
            )
    )
 ; Actions for storing samples
    (:action store-sample

        :parameters (?r - rover ?s - sample ?l - lander ?w - waypoint)

        :precondition
            (and
                (assigned ?r ?l)

                (carrying-sample ?r ?s)

                (at-rover ?r ?w)
                (at-lander ?l ?w)

                (lander-space-free ?l)
            )

        :effect
            (and
                (sample-stored ?s ?l)

                (sample-space-free ?r)

                (not (carrying-sample ?r ?s))
                (not (lander-space-free ?l))
            )
    )

)