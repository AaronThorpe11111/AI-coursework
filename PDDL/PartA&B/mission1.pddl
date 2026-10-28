
(define (problem lunar-mission-1)

    (:domain lunar)

    (:objects

        rover1 - rover

        lander1 - lander

        wp1 wp2 wp3 wp4 wp5 - waypoint

        image1 scan1 - data

        sample1 - sample
    )

    (:init

        ; Rover belongs to Lander 1
        (assigned rover1 lander1)

        ; Rover starts aboard the lander
        (aboard rover1 lander1)

        ; Chosen landing location
        (at-lander lander1 wp1)

        ; Rover capacity predicates
        (memory-free rover1)
        (sample-space-free rover1)

        ; Lander can store one sample
        (lander-space-free lander1)

        ; Waypoints

        (connected wp1 wp2)
        (connected wp1 wp4)

        (connected wp2 wp3)

        (connected wp3 wp5)

        (connected wp4 wp3)

        (connected wp5 wp1)

        ; Mission resources

        ; Image located at WP5
        (image-site image1 wp5)

        ; Scan located at WP3
        (scan-site scan1 wp3)

        ; Sample located at WP1
        (sample-site sample1 wp1)
    )

    (:goal
        (and

            ; Save image to Lander 1
            (transmitted image1 lander1)

            ; Save scan to Lander 1
            (transmitted scan1 lander1)

            ; Store sample in Lander 1
            (sample-stored sample1 lander1)
        )
    )

)