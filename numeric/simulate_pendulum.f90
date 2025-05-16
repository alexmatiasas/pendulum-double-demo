program simulate_pendulum
  implicit none
  real(8) :: t, dt, Tfinal
  real(8) :: theta1, omega1, theta2, omega2
  real(8) :: m1, m2, l1, l2, g
  integer :: i, nsteps

  ! Parámetros
  m1 = 1.0d0
  m2 = 1.0d0
  l1 = 1.0d0
  l2 = 1.0d0
  g = 9.81d0
  dt = 0.01d0
  Tfinal = 10.0d0
  nsteps = int(Tfinal/dt)

  ! Condiciones iniciales
  theta1 = 1.0d0
  omega1 = 0.0d0
  theta2 = 1.5d0
  omega2 = 0.0d0

  open(unit=10, file="data/pendulum_output.csv", status="replace")
  write(10,'(A)') "t,theta1,omega1,theta2,omega2"  ! encabezado correcto

  do i = 1, nsteps
    t = dt * (i-1)
    call step(theta1, omega1, theta2, omega2, m1, m2, l1, l2, g, dt)
    write(10,'(F8.4,",",F10.6,",",F10.6,",",F10.6,",",F10.6)') t, theta1, omega1, theta2, omega2
  end do

  close(10)
end program simulate_pendulum

subroutine step(th1, om1, th2, om2, m1, m2, l1, l2, g, dt)
  implicit none
  real(8), intent(inout) :: th1, om1, th2, om2
  real(8), intent(in) :: m1, m2, l1, l2, g, dt
  real(8) :: acc1, acc2
  real(8) :: sin_th1, cos_th1, sin_th2, cos_th2
  real(8) :: denom, num1, num2

  ! Trigonometría precomputada
  sin_th1 = sin(th1)
  cos_th1 = cos(th1)
  sin_th2 = sin(th2)
  cos_th2 = cos(th2)

  ! Aceleraciones reales derivadas de la forma simbólica (simplificada)
  denom = l1*(m1 + m2*(sin_th1**2 + cos_th1**2))
  num1 = -g*l1*(m1 + m2)*sin_th1
  num2 = -g*l2*m2*sin_th2

  acc1 = (num1 + num2) / denom
  acc2 = (num2 + num1) / denom  ! Placeholder: puedes refinar acc2 con la expresión completa más adelante

  ! Euler explícito
  om1 = om1 + acc1 * dt
  om2 = om2 + acc2 * dt
  th1 = th1 + om1 * dt
  th2 = th2 + om2 * dt
end subroutine step