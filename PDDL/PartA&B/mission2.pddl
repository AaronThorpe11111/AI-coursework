
(define (problem lunar-mission-2)

    (:domain lunar)

    (:objects

        rover1 rover2 - rover

        lander1 lander2 - lander

        wp1 wp2 wp3 wp4 wp5 wp6 - waypoint

        image1 image2 scan1 scan2 - data

        sample1 sample2 - sample
    )

    (:init

        ; -------------------------------
        ; Rover / Lander assignments
        ; -------------------------------

        (assigned rover1 lander1)
        (assigned rover2 lander2)

        ; -------------------------------
        ; Rover 1 starts deployed
        ; -------------------------------

        (deployed rover1)
        (at-rover rover1 wp2)

        ; -------------------------------
        ; Rover 2 starts aboard Lander 2
        ; -------------------------------

        (aboard rover2 lander2)

        ; -------------------------------
        ; Lander locations
        ; -------------------------------

        (at-lander lander1 wp2)

        ; chosen landing site for lander2
        (at-lander lander2 wp1)

        ; -------------------------------
        ; Rover capacities
        ; -------------------------------

        (memory-free rover1)
        (memory-free rover2)

        (sample-space-free rover1)
        (sample-space-free rover2)

        ; -------------------------------
        ; Lander capacities
        ; -------------------------------

        (lander-space-free lander1)
        (lander-space-free lander2)

        ; -------------------------------
        ; Connectivity
        ; -------------------------------

        (connected wp1 wp2)

        (connected wp2 wp1)
        (connected wp2 wp3)
        (connected wp2 wp4)

        (connected wp3 wp5)

        (connected wp4 wp2)

        (connected wp5 wp3)
        (connected wp5 wp6)

        (connected wp6 wp4)

        ; -------------------------------
        ; Mission resources
        ; -------------------------------

        ; image required from waypoint 3
        (image-site image1 wp3)

        ; image required from waypoint 2
        (image-site image2 wp2)

        ; scan required from waypoint 4
        (scan-site scan1 wp4)

        ; scan required from waypoint 6
        (scan-site scan2 wp6)

        ; sample required from waypoint 5
        (sample-site sample1 wp5)

        ; sample required from waypoint 1
        (sample-site sample2 wp1)
    )

    (:goal
        (and

            ; image at WP3 saved to Lander 1
            (transmitted image1 lander1)

            ; scan at WP4 saved to Lander 2
            (transmitted scan1 lander2)

            ; image at WP2 saved to Lander 2
            (transmitted image2 lander2)

            ; scan at WP6 saved to Lander 1
            (transmitted scan2 lander1)

            ; sample at WP5 stored in Lander 1
            (sample-stored sample1 lander1)

            ; sample at WP1 stored in Lander 2
            (sample-stored sample2 lander2)
        )
    )

)