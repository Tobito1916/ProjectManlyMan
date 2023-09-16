using Godot;

public partial class Movement : CharacterBody2D
{
	[Export]
	public int Speed { get; set; } = 400;

	private AnimationPlayer _animationPlayer;

    public override void _Ready()
    {
        _animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
    }
	public void GetInput()
	{

		Vector2 inputDirection = Input.GetVector("left", "right", "up", "down");
		Velocity = inputDirection * Speed;
		if (Input.IsActionPressed("right"))
		{
			_animationPlayer.Play("walk_right");
		}
		else
		{
			_animationPlayer.Stop();
		}
	}

	public override void _PhysicsProcess(double delta)
	{	
		GetInput();
		MoveAndSlide();
	}
}
