(define (domain lunar-extended)

    (:requirements :strips :typing)

    (:types
        rover
        lander
        waypoint
        data
        sample
        astronaut
    )



    (:predicates

        ; Rover and lander locations
        (at-rover ?r - rover ?w - waypoint)
        (at-lander ?l - lander ?w - waypoint)

        ; Rover deployment
        (aboard ?r - rover ?l - lander)
        (deployed ?r - rover)

        ; Ownership
        (assigned ?r - rover ?l - lander)

        ; Waypoint graph
        (connected ?from - waypoint ?to - waypoint)

        ; Data sites
        (image-site ?d - data ?w - waypoint)
        (scan-site ?d - data ?w - waypoint)

        ; Sample sites
        (sample-site ?s - sample ?w - waypoint)
        (sample-available ?s - sample)

        ; Rover memory
        (memory-free ?r - rover)
        (has-data ?r - rover ?d - data)
        (transmitted ?d - data ?l - lander)

        ; Sample carrying
        (sample-space-free ?r - rover)
        (carrying-sample ?r - rover ?s - sample)

        ; Lander storage
        (lander-space-free ?l - lander)
        (sample-stored ?s - sample ?l - lander)

        ; Astronaut ownership
        (astronaut-assigned ?a - astronaut ?l - lander)

        ; Astronaut location inside a lander
        (in-control-room ?a - astronaut ?l - lander)
        (in-docking-bay ?a - astronaut ?l - lander)
    )


    (:action move-to-control-room

        :parameters
            (?a - astronaut ?l - lander)

        :precondition
            (and
                (astronaut-assigned ?a ?l)
                (in-docking-bay ?a ?l)
            )

        :effect
            (and
                (in-control-room ?a ?l)
                (not (in-docking-bay ?a ?l))
            )
    )

    (:action move-to-docking-bay

        :parameters
            (?a - astronaut ?l - lander)

        :precondition
            (and
                (astronaut-assigned ?a ?l)
                (in-control-room ?a ?l)
            )

        :effect
            (and
                (in-docking-bay ?a ?l)
                (not (in-control-room ?a ?l))
            )
    )

 ; Action for deploying 
    (:action deploy

        :parameters
            (?r - rover
             ?l - lander
             ?w - waypoint
             ?a - astronaut)

        :precondition
            (and
                (assigned ?r ?l)
                (aboard ?r ?l)
                (at-lander ?l ?w)

                (astronaut-assigned ?a ?l)
                (in-docking-bay ?a ?l)
            )

        :effect
            (and
                (deployed ?r)
                (at-rover ?r ?w)

                (not (aboard ?r ?l))
            )
    )
 ; Acting for moving from one waypoint to another
    (:action move

        :parameters
            (?r - rover
             ?from - waypoint
             ?to - waypoint)

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

        :parameters
            (?r - rover
             ?d - data
             ?w - waypoint)

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

; Action for performing a scan
    (:action perform-scan

        :parameters
            (?r - rover
             ?d - data
             ?w - waypoint)

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
; Action for transmitting the data 
    (:action transmit-data

        :parameters
            (?r - rover
             ?d - data
             ?l - lander
             ?a - astronaut)

        :precondition
            (and
                (assigned ?r ?l)
                (has-data ?r ?d)

                (astronaut-assigned ?a ?l)
                (in-control-room ?a ?l)
            )

        :effect
            (and
                (transmitted ?d ?l)

                (memory-free ?r)

                (not (has-data ?r ?d))
            )
    )
; Action for collecting a sample
    (:action collect-sample

        :parameters
            (?r - rover
             ?s - sample
             ?w - waypoint)

        :precondition
            (and
                (at-rover ?r ?w)
                (sample-site ?s ?w)
                (sample-available ?s)
                (sample-space-free ?r)
            )

        :effect
            (and
                (carrying-sample ?r ?s)

                (not (sample-space-free ?r))
                (not (sample-available ?s))
            )
    )
; Action to store the sample
    (:action store-sample

        :parameters
            (?r - rover
             ?s - sample
             ?l - lander
             ?w - waypoint
             ?a - astronaut)

        :precondition
            (and
                (assigned ?r ?l)

                (carrying-sample ?r ?s)

                (at-rover ?r ?w)
                (at-lander ?l ?w)

                (lander-space-free ?l)

                (astronaut-assigned ?a ?l)
                (in-docking-bay ?a ?l)
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