(define (problem lunar-mission-3)

    (:domain lunar-extended)

    (:objects

        rover1 rover2 - rover
        lander1 lander2 - lander

        alice bob - astronaut
        wp1 wp2 wp3 wp4 wp5 wp6 - waypoint
        image1 image2 scan1 scan2 - data
        sample1 sample2 - sample
    )

    (:init

        ; Rover and Lander assignments
        (assigned rover1 lander1)
        (assigned rover2 lander2)

        ; Astronaut assignments
        (astronaut-assigned alice lander1)
        (astronaut-assigned bob lander2)

        ; The locations where the astronauts will be starting
        (in-docking-bay alice lander1)
        (in-control-room bob lander2)

        ; Rover 1 starts deployed at WP2
        (deployed rover1)
        (at-rover rover1 wp2)

        ; Rover 2 starts aboard Lander 2
        (aboard rover2 lander2)

        ; Lander locations
        (at-lander lander1 wp2)

        ; Chosen landing site for Lander 2
        (at-lander lander2 wp1)

        ; Rover capacities

        (memory-free rover1)
        (memory-free rover2)

        (sample-space-free rover1)
        (sample-space-free rover2)

        ; Lander capacities

        (lander-space-free lander1)
        (lander-space-free lander2)

        ; Waypoints

        (connected wp1 wp2)

        (connected wp2 wp1)
        (connected wp2 wp3)
        (connected wp2 wp4)

        (connected wp3 wp5)

        (connected wp4 wp2)

        (connected wp5 wp3)
        (connected wp5 wp6)

        (connected wp6 wp4)

        ; Image locations

        (image-site image1 wp3)
        (image-site image2 wp2)

        ; Scan locations

        (scan-site scan1 wp4)
        (scan-site scan2 wp6)

        ; Sample locations

        (sample-site sample1 wp5)
        (sample-site sample2 wp1)

        ; Samples available

        (sample-available sample1)
        (sample-available sample2)
    )

    (:goal
        (and

            ; Data sent to Lander 1
            (transmitted image1 lander1)
            (transmitted scan2 lander1)

            ; Data sent to Lander 2
            (transmitted image2 lander2)
            (transmitted scan1 lander2)

            ; Samples stored

            (sample-stored sample1 lander1)
            (sample-stored sample2 lander2)
        )
    )

)