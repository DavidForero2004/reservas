/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package persistencia;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;
import javax.persistence.Persistence;
import modelo.reserva;
import persistencia.exceptions.NonexistentEntityException;
import javax.persistence.TypedQuery;

/**
 *
 * @author david
 */
public class reservaJpaController implements Serializable {

    public reservaJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public reservaJpaController() {
        emf = Persistence.createEntityManagerFactory("ReservasPU");
    }

    public void create(reserva reserva) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(reserva);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(reserva reserva) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            reserva = em.merge(reserva);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = reserva.getId();
                if (findreserva(id) == null) {
                    throw new NonexistentEntityException("The reserva with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            reserva reserva;
            try {
                reserva = em.getReference(reserva.class, id);
                reserva.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The reserva with id " + id + " no longer exists.", enfe);
            }
            em.remove(reserva);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<reserva> findreservaEntities() {
        return findreservaEntities(true, -1, -1);
    }

    public List<reserva> findreservaEntities(int maxResults, int firstResult) {
        return findreservaEntities(false, maxResults, firstResult);
    }

    private List<reserva> findreservaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(reserva.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public reserva findreserva(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(reserva.class, id);
        } finally {
            em.close();
        }
    }

    public int getreservaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<reserva> rt = cq.from(reserva.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

    public List<reserva> findReservasByUser(Integer id_usuario) {
        EntityManager em = getEntityManager();
        String FindQuery = "SELECT r FROM reserva r JOIN FETCH r.Estado WHERE r.Usuario.id = :id_usuario";

        try {
            TypedQuery<reserva> query = em.createQuery(
                    FindQuery,
                    reserva.class
            );
            query.setParameter("id_usuario", id_usuario);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

}
