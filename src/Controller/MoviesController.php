<?php

namespace App\Controller;

use App\Repository\MoviesRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Serializer\Annotation\Groups;

#[Route('/movies')]
class MoviesController extends AbstractController
{

    private $moviesRepo;
    private $serializer;

    public function __construct(MoviesRepository $moviesRepo, SerializerInterface $serializer) 
    {
        $this->moviesRepo = $moviesRepo;
        $this->serializer = $serializer;
    }

    #[Route('/', name: 'get_movies', methods: ['GET'])]
    public function getAllMovies(): JsonResponse
    {
        $movies = $this->moviesRepo->findAll();

        $data = $this->serializer->normalize($movies, null, ['groups' => 'movies']);

        return $this->json($data);
    }

    #[Route('/{id}', name: 'get_movie', methods: ['GET'])]
    public function getOneMovie(): JsonResponse
    {
        $movie = $this->moviesRepo->find($id);

        $data = $this->serializer->serialize($movie, 'json');

        return $this->json($data);
    }

    #[Route('/', name: 'add_movie', methods: ['POST'])]
    public function addMovie(Request $request, EntityManagerInterface $em): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        if (!isset($data['title']) || !isset($data['resume']) || !isset($data['date_sortie']) || !isset($data['realisateur'])) {
            return $this->json([
                'message' => 'title, resume, date_sortie and realisateur are required'
            ], 400);
        }

        $movie = new Movies();
        $movie->setTitle($data['title']);
        $movie->setResume($data['resume']);
        $movie->setDateSortie($data['date_sortie']);
        $movie->setRealisateur($data['realisateur']);

        $em->persist($movie);
        $em->flush();

        return $this->json($data);
    }

    #[Route('/{id}', name: 'edit_movie', methods: ['PUT'])]
    public function editMovie(movies $movie, Request $request, EntityManagerInterface $em): JsonResponse
    {
        if (!$movie) {
            return $this->json([
                'message' => 'Movie not found'
            ], 404);
        }

        $data = json_decode($request->getContent(), true);

        if (!isset($data['title'])) {
            $movie->setTitle($data['title']);
        }

        if (!isset($data['resume'])) {
            $movie->setResume($data['resume']);
        }

        if (!isset($data['date_sortie'])) {
            $movie->setDateSortie($data['date_sortie']);
        }

        if (!isset($data['realisateur'])) {
            $movie->setRealisateur($data['realisateur']);
        }

        $em->persist($movie);
        $em->flush();

        return $this->json([
            'message' => 'Movie updated successfully',
        ]);
    }

    #[Route('/{id}', name: 'delete_movie', methods: ['DELETE'])]
    public function deleteMovie(Movies $movie, EntityManagerInterface $em): JsonResponse
    {
        if (!$movie) {
            return $this->json([
                'message' => 'Movie not found'
            ], 404);
        }

        $em->remove($movie);
        $em->flush();

        return $this->json([
            'message' => 'Movie deleted successfully',
        ]);
    }
}
